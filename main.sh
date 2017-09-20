#!/bin/bash

MAX_RULE=15

APP_TYPES=`aws ec2 describe-security-groups --group-name default | jq -r \ '.["SecurityGroups"] | .[0] | .["IpPermissions"]' | jq length`
MAX_APP=0
SAVE_APP=0
for (( i=0; i<$APP_TYPES; i++ ))
do
FIND=`aws ec2 describe-security-groups --group-name default | jq -r \ '.["SecurityGroups"] | .[0] | .["IpPermissions"] | .['"$i"'] | .["IpRanges"]' | jq length`
if [ $FIND -gt $MAX_APP ]
then
        MAX_APP=$FIND
        SAVE_APP=$i
fi
done

if [ $MAX_APP -gt $MAX_RULE ]
then
for (( i=0; i<$APP_TYPES; i++ ))
do
        PORT=`aws ec2 describe-security-groups --group-name default | jq -r \ '.["SecurityGroups"] | .[0] | .["IpPermissions"] | .['"$i"'] | .["FromPort"]'`
        if [ $PORT -eq 22 ]
        then
        for (( j=0; j<$MAX_APP; j++ ))
        do
                CIDR=`aws ec2 describe-security-groups --group-name default | jq -r \ '.["SecurityGroups"] | .[0] | .["IpPermissions"] | .['"$i"'] | .["IpRanges"] | .[0] | .["CidrIp"]'`
                #echo $CIDR
		aws ec2 revoke-security-group-ingress --group-name default --protocol tcp --port 22 --cidr $CIDR
        done
	i=$((i-1))
	APP_TYPES=$((APP_TYPES-1))
        fi
done
fi


DB_TYPES=`aws ec2 describe-security-groups --group-name launch-wizard-1 | jq -r \ '.["SecurityGroups"] | .[0] | .["IpPermissions"]' | jq length`

MAX_DB=0
SAVE_DB=0
for (( i=0; i<$DB_TYPES; i++ ))
do
FIND=`aws ec2 describe-security-groups --group-name launch-wizard-1 | jq -r \ '.["SecurityGroups"] | .[0] | .["IpPermissions"] | .['"$i"'] | .["IpRanges"]' | jq length`
if [ $FIND -gt $MAX_DB ]
then 
	MAX_DB=$FIND
	SAVE_DB=$i
fi
done

if [ $MAX_DB -gt $MAX_RULE ]
then
for (( i=0; i<$DB_TYPES; i++ ))
do
	PORT=`aws ec2 describe-security-groups --group-name launch-wizard-1 | jq -r \ '.["SecurityGroups"] | .[0] | .["IpPermissions"] | .['"$i"'] | .["FromPort"]'`
	if [ $PORT -eq 80 ]
	then
	for (( j=0; j<$MAX_DB; j++ ))
	do
		CIDR=`aws ec2 describe-security-groups --group-name launch-wizard-1 | jq -r \ '.["SecurityGroups"] | .[0] | .["IpPermissions"] | .['"$i"'] | .["IpRanges"] | .[0] | .["CidrIp"]'`
		#echo $CIDR
		aws ec2 revoke-security-group-ingress --group-name launch-wizard-1 --protocol tcp --port 80 --cidr $CIDR
	done
	i=$((i-1))
        DB_TYPES=$((DB_TYPES-1))
	fi
	
	if [ $PORT -eq 22 ]
        then
        for (( j=0; j<$MAX_DB; j++ ))
        do
                CIDR=`aws ec2 describe-security-groups --group-name launch-wizard-1 | jq -r \ '.["SecurityGroups"] | .[0] | .["IpPermissions"] | .['"$i"'] | .["IpRanges"] | .[0] | .["CidrIp"]'`
                #echo $CIDR
                aws ec2 revoke-security-group-ingress --group-name launch-wizard-1 --protocol tcp --port 22 --cidr $CIDR
        done
        i=$((i-1))
        DB_TYPES=$((DB_TYPES-1))
        fi
done
fi

aws ec2 authorize-security-group-ingress --group-name default --protocol tcp --port 22 --cidr $1
aws ec2 authorize-security-group-ingress --group-name launch-wizard-1 --protocol tcp --port 22 --cidr $1
aws ec2 authorize-security-group-ingress --group-name launch-wizard-1 --protocol tcp --port 80 --cidr $1
