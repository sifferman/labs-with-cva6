
# Storing Class Materials in Your Own GitHub Repository

This guide offers the method of code organization and collaboration that we recommend.

## Git/GitHub Setup Steps

1. The labs are recommended to be completed in groups of 3, so we recommend [creating a GitHub organization](https://github.com/account/organizations/new?plan=free) for your group.

2. Create a new *public or private*[^1] GitHub repository and clone it to your machine. You can either make a new repository for each lab, or use the same repository for all labs.

3. If you made a private repository, give the instructors read-access to your repository. Their GitHub usernames are "dstrukov" and "sifferman".

4. Add [labs-with-cva6](https://github.com/sifferman/labs-with-cva6) as a submodule with `git submodule add git@github.com:sifferman/labs-with-cva6.git`.

5. If you ever need to change the commit of your [labs-with-cva6](https://github.com/sifferman/labs-with-cva6) submodule, you will need to do the following:

  1. `cd labs-with-cva6`
  2. `git pull origin main` to grab the latest commit, or `git checkout <COMMIT HASH>` to grab a specific commit
  3. `cd ..`
  4. `git submodule update --init --recursive`
  5. `git add labs-with-cva6`
  6. `git commit -m "<MESSAGE, i.e. updated labs-with-cva6>"`
  7. `git push origin main`

## CVA6 Source Replacement Setup

**TODO**

## Footnotes

[^1]: Disclaimer: You are welcome to make any code you write yourself publicly available, although your submission will be verified with a strong similarity report checker. Learning from online resources is encouraged, but blatant plagiarism will not be tolerated.
