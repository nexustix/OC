# nxnet - networking for OC

## Requirements
  - Transmit arbitrary amount of data
  - Transmit data over log distances
  - Easy to maintain infrastructure
  - Simple setup for end user

## Draft:

### Node
  (Computer, Server)
  - ~~Keep index of connected Nodes by UUID~~
  - If node is receiver make Package acessible via local network
    - Email-ish solution
      - Make received Packages poll-able
      - Only wired ?
      - notify network ?
    - Direct solution
      - Just sent data to all devices on the local network
      - Only wired ?  
  - Transmit every received Package to every connected Node
    - ~~Don't transmit message to a Node that has allready seen the message~~
    - Only when "self" is not in list of visited nodes
    - implement routing via a form of IP if neccesary ?
  - Add "self" to visited nodes before sending
  - Mind power usage (only send if having enough power stored)

### Package
(Data representation)
  - Contains serialized data in Lisp like format
  - Contains data
  - Contains Receiver
    - part of UUID
  - Contains visited Nodes
    - part(s) of UUID(s)
  - Contains Sender ?
