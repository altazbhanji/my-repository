# Updating Your Local Repository

- Open command prompt

- Go to the directory where you have `already` cloned the `clarusway` public repository (i.e. `clarusway-aws-2-22-DE`)

- At the prompt, type `git pull`

- Copy the folder:
    - `clarusway-aws-2-22-DE\python\hands-on\flask-03-04-If-Handling-Routes-and-Get-Post-Methods`
    to
    - `Desktop\my-repository\python\hands-on\flask-03-04-If-Handling-Routes-and-Get-Post-Methods`
(assuming this is where you have created `my-repository`)

#
# Updating Your Remote Repository

- (You can also do this via VS code if you are familiar.  We will try this next time)

- Open command prompt

- Go to the directory where you have created `my-repository` (should be on the Desktop)

- type `git add .`

- type `git commit -m "adding code for Portfolio 2 class"`

- type `git push`
    

#
# Setup Amazon Linux 2 with Flask

- log in using ssh and your .pem key file

- type `sudo yum -y update`

- type `sudo yum -y install git`

- type `sudo yum -y install python3`

- type `sudo pip install flask`

- Make sure your repository in git hub is `public`

- type `git clone <repository url>`

#
# Running Your Flask Application on EC2

- change this line in 'app.py':
```python
     app.run(debug=True)
```
to:
```python
    app.run(host='0.0.0.0', port=80)
```
