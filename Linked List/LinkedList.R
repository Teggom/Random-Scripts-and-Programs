Node <- list(Data = NULL, Next = NULL, Type = "Node")

LinkedList.Create <- function(Data){
  NewNode <- Node
  NewNode$Data <- Data
  return(NewNode)
}

LinkedList.RemoveOne <- function(Data, LinkedList){
  if(is.null(LinkedList)){
    return(NULL)
  }
  if(is.null(Data) || is.na(Data)){
    return(LinkedList)
  }
  if(LinkedList$Data == Data){
    return(LinkedList$Next)
  }
  LinkedList$Next <- LinkedList.RemoveOne(Data = Data, LinkedList = LinkedList$Next)
  return(LinkedList)
}

LinkedList.RemoveIndex <- function(Index, LinkedList){
  if(is.null(LinkedList)){
    return(NULL)
  }
  if(Index == 0 || !is.numeric(Index)){
    return(LinkedList$Next)
  }
  LinkedList$Next <- LinkedList.RemoveIndex(LinkedList = LinkedList$Next, Index = Index -1)
  return(LinkedList)
}

LinkedList.Get <- function(Index, LinkedList){
  if(Index==0 || !is.numeric(Index)){
    return(LinkedList$Data)
  }
  if(is.null(LinkedList$Next)){
    return(NULL)
  }
  return(LinkedList.Get(Index = Index - 1, LinkedList = LinkedList$Next))
}

LinkedList.Add <- function(Data, LinkedList){
  if(is.null(Data)){
    warning("Cannot Create node with NULL Parameter")
    return(LinkedList)
  }
  if(is.null(LinkedList$Next)){
    NewNode <- Node
    NewNode$Data <- Data
    LinkedList$Next <- NewNode
    return(LinkedList)
  }
  LinkedList$Next <- LinkedList.Add(Data = Data, LinkedList = LinkedList$Next)
  return(LinkedList)
}

LinkedList.Set <- function(LinkedList, Index, Data){
  if(is.null(LinkedList)){
    return(NULL)
  }
  if(is.na(Data) || is.null(Data) || !is.integer(Index)){
    warning("Bad Parameters")
    return(LinkedList)
  }
  if(Index == 0){
    LinkedList$Data <- Data
    return(LinkedList)
  }
  LinkedList$Next <- LinkedList.Set(LinkedList = LinkedList$Next, Index = Index - 1, Data = Data)
  return(LinkedList)
}

