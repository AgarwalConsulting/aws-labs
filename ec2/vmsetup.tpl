#!/bin/bash
apt-get update
apt-get install -y xfce4 xfce4-goodies tightvncserver
mkdir -p /home/ubuntu/.vnc
echo "labs2023" | vncpasswd -f > /home/ubuntu/.vnc/passwd
chown -R ubuntu:ubuntu /home/ubuntu/.vnc
chmod 0600 /home/ubuntu/.vnc/passwd
cat > /home/ubuntu/.vnc/xstartup << EOL
#!/bin/sh
xrdb $HOME/.Xresources
startxfce4 &
EOL

apt install -y golang
snap install code --classic

# set GOPATH & PATH
echo 'export GOPATH=$HOME/go' >> /home/ubuntu/.bash_load # Or some other path in your system
echo 'export PATH="$GOPATH/bin:$PATH"' >> /home/ubuntu/.bash_load
chown -R ubuntu:ubuntu /home/ubuntu/.bash_load
echo 'source /home/ubuntu/.bash_load' >> /home/ubuntu/.bashrc
echo 'source /home/ubuntu/.bash_load' >> /home/ubuntu/.bash_profile
chown -R ubuntu:ubuntu /home/ubuntu/.bashrc
chown -R ubuntu:ubuntu /home/ubuntu/.bash_profile

git clone https://github.com/AgarwalConsulting/Go-Training.git /home/ubuntu/Go-Training
chown -R ubuntu:ubuntu /home/ubuntu/Go-Training

chmod +x /home/ubuntu/.vnc/xstartup
chown -R ubuntu:ubuntu /home/ubuntu/.vnc/xstartup
su - ubuntu -c 'vncserver :1 -geometry 1920x1080'
