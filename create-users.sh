#!/bin/bash
accounts=$(cat usernames.txt)

if [[ ! -f usernames.txt ]] ; then
    echo 'The "username.txt" is missing, aborting.'
    exit

        else

for i in $accounts;
   do
#     echo $i   #print usernames while creating accounts
      sudo useradd -m -s /bin/bash "$i"
      echo "$i:changePASSWORD!" | sudo chpasswd
      sudo chown -R "$i:$i" "/home/$i"
      sudo chmod 700 "/home/$i"
done

echo -e "\nResults: \n"
sudo cat /etc/passwd | grep -i "$i*"

#sudo group request
echo ""
while true; do
     read -p "Add users to the sudo group? [Y/n]" input
     case $input in
        [yY]* )  for i in $accounts; do sudo usermod -aG sudo "$i"; done
                 echo -e "\nUsers are added to the sudo group"; break;;
        [nN]* )  echo -e "\nUsers will not be added to the sudo group"; break;;
        * ) echo -e "\nInvalid response";;
     esac
done
echo ""
for i in $accounts; do id $i; done

fi
