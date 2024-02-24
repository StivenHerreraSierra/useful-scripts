#!/bin/bash

echo -e "[ Modifying DNF config to exclude kernel updates ]\n"
sudo echo "exclde=kernel*" >> /etc/dnf/dnf.conf

echo -e "[ You have installed the following kernels ]\n"
rpm -q kernel

read -p "Do you wanna to remove some of them?" RESPONSE
if [ $RESPONSE =~ "[Yy]" ]
then
		read -a KERNEL_NAMES -p "Please give me the name for each kernel that you wanna to remove, separating them by space: "
		
		for i in ${KERNEL_NAMES[@]}
		do
				kernel-install remove $i
		done
fi
