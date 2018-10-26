This is simply a proof of concept for pointers in R. 

IE calling 
	>A = c(1, 2, 3)
	>B = A
	>A[1] = 4
	>B
	prints 1

Ideally A and B would reference a Hash that would in turn get passed to every function and is itself a variable, except hidden. 

Because of this A would simply point to the hash and assigning B to A will also cause B to point to the hash. The only thing that ever gets changed in runtime would be variables assigned to the Hashes. 


Not finished, just put on the todo list!