extends Object


var a = 0.0
var input = 0.0
var cached_a =0.0
var inps = []
var inpWeights = []
var bias = 0.0
var eta = 0.1
var error = 0
var cached_errors = []
var maxActivation = 5

func forward():
	cached_a=bias+input
	
	if len(inps)>0:
		for i in range(len(inps)):
#			print(i)
			cached_a+=inps[i].a*inpWeights[i]
		
	
	if cached_a < 0:
		cached_a*=0.5
			
	
func backprop():
	cached_errors = []
	error *= eta
	
	if a<0:
		error*=0.5
		
	bias -= error
	bias = max(min(bias,1.0),-1.0)
	for i in range(len(inps)):
		inpWeights[i] += error*-1*inps[i].a
		inpWeights[i] = max(min(inpWeights[i],10.0),-10.0)
		cached_errors.append(-1*inpWeights[i]*error)
			

func decayWeights(decay=0.99):
	for i in range(len(inpWeights)):
		inpWeights[i] = decay*inpWeights[i]
	
func preBackUpdate():
	forward()
	backprop()
	input = 0
	error = 0
	
func preUpdate():
	forward()
	for i in range(len(inps)):
		cached_errors.append(0)
	input = 0
	error = 0
	
func postUpdate():
	a = cached_a
	a = max(min(a,maxActivation),-1*maxActivation)
	for i in range(len(inps)):
		inps[i].error=cached_errors[i]
	
		
	
	
	


