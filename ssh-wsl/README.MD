## SSH-AGENT FOR WSL

---
Inspiration taken from [this github repository](https://github.com/bahamas10/windows-bash-ssh-agent).

---
Steps to reproduce :

1. create folder C:\Users\CURRENT_USER\.ssh\scripts
2. move both start scripts inside this folder
3. launch WSL
 - create a symlink to the .ssh folder you created :
 ```bash
 ln -s /mnt/c/Users/CURRENT_USER/.ssh $HOME/.ssh
 ```
 
 - modify your .bashrc file to source the environment file that contains the ssh-agent configuration :
 ```bash
 if uname -a | grep -q '^Linux.*Microsoft'; then
      . ~/.ssh/environment
 fi
 ```

4. launch taskschd.msc
5. create a new task
    - tick "Execute with maximal authorizations"
    - for "Triggers", chose "When a Windows session is opened"
    - for "Actions", put :
        - Program : `C:\Users\CURRENT_USER\.ssh\scripts\start-hidden.vbs`
        - Arguments : `"C:\Windows\System32\bash.exe -c '~/.ssh/scripts/start-ssh-agent.sh'"` (with correct quotation)

Your bash ssh-agent should now launch whenever you log in your windows session. It should ask you for ssh credentials only once per session.
