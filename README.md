# progetto_CFD
Project for Computational Fluid Dynamics exam

how to use git:

First of all -if you are not using github desktop- you will need to download git and install it on your computer. Other wise on github desktop it is pretty simple and guided.
Once installed, you will be able to download the repository, but first you have to set up a couple of things:

- navigate to the folder where you want to download your repo.
- right click in the folder and select "git bash here"

it will open a terminal like window, but that is not the command window, it is a git command window from which you communicate with the server where the repository is hosted. Now in the git bash terminal write these commands:

- git clone PASTE_THE_URL

now close the git terminal and right click the folder progetto_CFD, then select open git bash. 

now write the following lines, where instead of TYPE write global or local whether you want to set global or local configurations. The same applies for USERNAME (write your github username) and EMAIL (write your github email):

- git config --TYPE user.name "USERNAME"
- git config --TYPE user.email "EMAIL"

(note the apices, you will need to write them)

now you have downloaded the repository and set the configuration files.

now when you want to download the changes just use the command:

- git pull

and when you want to add changes to the repository just write:

- git add .

to add all changes, 

- git commit " bla bla bla "

where you write what you are committing to the repository

and eventually 

- git push

to push the changes on the repo.

it's good practice to pull every time you have to push new commits, so that you remain updated and don't generate conflicts.

