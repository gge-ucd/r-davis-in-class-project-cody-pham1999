hrMinConvert <- function(vec, convert.to) {
  if(convert.to == "hours") {
    vec.hours <- vec/60 ## convert to hours
    
    return(vec.hours) ## return converted vector
  } else if(convert_to == "minutes") {
    vec.minutes <- vec*60 ## convert to minutes
    
    return(vec.minutes) ## return converted vector
  } else {
    ## notify of invalid input
    print("argument convert.to must be string `hours` or `minutes`")
  }
}