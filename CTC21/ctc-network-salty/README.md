# ctc-network-salty
SaltStack challenge for CTC 2021
This challenge belongs to the Networking category. Two docker container are ran in order to setup the environment. 
The dhcp-server-master container is supposed to give access to the challenge envrinment via SSH access. The machine does not need any other outbound connection, everything needed to solve
the challenge is already pre-installed in the container. The candidate obtains the flag once remote code execution is realized successfully on the minion container, that must be done exploiting
the salt-minion service. The docker containers can reach each other by means of a network bridge realized via virtual ethernet devices. Every candidate must have indipendent access to the 
environment, shared envrinment would result most likely in a not proper operation of the challenge.  

## Usage
From the project folder:

```bash
./initiate.sh IP-TO-ASSIGN-TO-MASTER
```
Example: ./initiate.sh 10.10.10.5

Virtual ethernet devices are created in order to setup the bridge between the container. 

## Structure
- dhcp-server-master: This container gives access to the "challenge network environment". Candidate gets access to this container via SSH and the challenge can start. All the steps needed to 
solve the challenge must be taken on this docker container. 
- minion: This container contains the flag. Scripts in order to update system configuration when the right exploit is executed are ran by the supervisor, furthermore the supervisor takes care of
salt-minion operation.
- config:
    - supervisord.conf --> the supervisord config used to run multiple services simultaneously in one docker container
- docs: documentation on challenge solution ( coming soon )
