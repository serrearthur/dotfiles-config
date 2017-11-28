#########################
### SSH-AGENT FOR WSL ###
#########################

inspiration taken from this github repository :
https://github.com/bahamas10/windows-bash-ssh-agent

Steps to reproduce :
1) create folder C:\Users\CURRENT_USER\.ssh\scripts
2) move both start scripts inside this folder
3) launch WSL :
    a) create a symlink to the .ssh folder you created :
       ln -s /mnt/c/Users/CURRENT_USER/.ssh $HOME/.ssh
    b) modify your .bashrc file to source the environment file that contains the ssh-agent configuration :
       if uname -a | grep -q '^Linux.*Microsoft'; then
	     . ~/.ssh/environment
       fi
4) launch taskschd.msc
5) create a new task
	a) tick "Execute with maximal authorizations"
	b) for "Triggers", chose "When a Windows session is opened"
	c) for "Actions", put :
		*) Program : C:\Users\CURRENT_USER\.ssh\scripts\start-hidden.vbs
		*) Arguments : "C:\Windows\System32\bash.exe -c '~/.ssh/scripts/start-ssh-agent.sh' " (with correct quotation)

Your bash ssh-agent should now launch whenever you log in your windows session. It should ask you for ssh credentials only once per session.
