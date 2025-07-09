# **Looker Fan-Out Solutions: A Practical Guide**

This LookML project provides a hands-on demonstration of various data modeling techniques to solve the common "fan-out" problem in Looker. The models are based on the excellent strategies outlined in the Google Cloud Community article: [Outer Join on False (or How I learned to stop fanning out and...)](https://www.googlecloudcommunity.com/gc/Modeling/Outer-Join-on-False-or-How-I-learned-to-stop-fanning-out-and/td-p/573726).

## **The Fan-Out Problem**

A "fan-out" occurs when you join a primary table to multiple other tables in one-to-many relationships. This creates a Cartesian product between the joined tables, causing measures from the "one" side of the relationships to be duplicated and incorrectly inflated.

In this project, we have a central accounts table. Each account can have multiple managers and multiple products. When we join all three in a single Explore, our measure for Total Employees will be wrong. This project demonstrates how to avoid that.

## **Modeling Approaches**

This project contains three distinct models, each with its own Explore, to illustrate the problem and the solutions.

### **1\. The Fan-Out Example (fanout\_example)**

* **File:** models/1\_fanout\_example.model.lkml  
* **Explore Label:** Fan-Out Example

This model uses simple LEFT JOINs to connect accounts, managers, and products. It is designed to **demonstrate the fan-out problem**.

**To see the issue:**

1. Open the "Fan-Out Example" Explore.  
2. Select the measure Total Employees from the Accounts view.  
3. Add the dimension Name from the Managers view.  
4. Add the dimension Name from the Products view.

You will notice that the Total Employees value is dramatically inflated because it's being multiplied by the number of managers and products associated with each account.

### **2\. The FULL OUTER JOIN ON FALSE Solution (full\_outer\_join\_solution)**

* **File:** models/2\_full\_outer\_join.model.lkml  
* **Explore Label:** Full Outer Join Solution

This model implements the primary technique from the article. By joining the managers and products views using type: full\_outer and a false sql\_on: 1=0 condition, we prevent a direct join relationship. This brings the data into the same Explore while allowing Looker's Symmetric Aggregates to function correctly, ensuring that all measures are calculated accurately.

### **3\. The Advanced COALESCE Solution (advanced\_coalesce\_solution)**

* **File:** models/3\_normalized\_schema.model.lkml  
* **Explore Label:** Advanced Coalesce Solution

This is the most robust and flexible pattern, also derived from the article. It builds upon the FULL OUTER JOIN ON FALSE technique.

1. **Fact Tables (managers\_base, products\_base)**: We first bring in the managers and products views using the full\_outer join on a false condition, but we give them aliases.  
2. **Dimension Table (associated\_account)**: We then LEFT JOIN the accounts view again, but this time we use a COALESCE() function in the sql\_on parameter. This function intelligently finds the correct account to link to, whether the row of data came from the managers join or the products join.

This pattern creates a clean, reliable Explore where dimensions from the accounts view can be used with measures from any of the joined views without any risk of fanning out.
