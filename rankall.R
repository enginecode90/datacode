# this function  Returns hospital name with the given rank for 30-day death rate by state

rankall <- function(outcome, num=1) {
        ## Read outcome data
        outcome_df <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        
        ## Check that outcome are valid
        outcomes <- c('heart attack', 'heart failure', 'pneumonia')
        if(!any(outcomes == outcome)) {
                stop("invalid outcome")
        }
        ## check num is valid
        # nums <- c('best', 'worst')
        # if(!any(nums == num)) {
        #        if(!all.equal(num, as.integer(num))) {
        #                stop("invalid rank")
        #        }
        # }
        
        
        ## Return hospital name with the given rank for 30-day death rate by state
        # sort for ties
        outcome_df <- outcome_df[order(outcome_df[2]),]
        # lookup columns for outcome
        mortalityCol <- c(11, 17, 23)
        names(mortalityCol) <- outcomes
        col <- mortalityCol[[outcome]]
        
        # convert column to numeric
        for(i in mortalityCol) {
                suppressWarnings(outcome_df[,i] <- as.numeric(as.character(outcome_df[,i])))
        }
        
        # sort 30-day mortality rates by rank then by state
        outcome_df <- outcome_df[order(outcome_df[col]),]
        outcome_df <- outcome_df[order(outcome_df$State),]
        
        #### add for loop to go through states and add ranks
        rank_df <- outcome_df[,c(2, 7, col)]
        for(i in unique(rank_df$State)) {
                for(j in 1:nrow(rank_df[rank_df$State == i,])) {
                        rank_df$Rank[rank_df$State == i][j] <- j
                }
        }
        
        colnames(rank_df)[3] <- 'Rate'
        num_states <- length(unique(outcome_df$State))
        n <- 0
        
        # find rank for each state based on num sent
        # allow for number rank or 'best' / 'worst'
        if(num == 'best') {
                n <- as.list(rep(1, num_states))
        } else if(num == 'worst') {
                j <- 1
                for(i in unique(rank_df$State)) {
                        n[j] <- which.max(rank_df$Rate[rank_df$State == i])
                        j = j + 1
                }
                
        } else {
                n <- as.list(rep(num, num_states))
        }
        
        # find matching rank by state
        Hname <- rank_df[1,]
        j <- 1
        for(i in unique(rank_df$State)) {
                # if rank doesn't exist for state send 'NA'
                if(length(rank_df[rank_df$Rank == n[j] & rank_df$State == i,'State']) > 0) {
                        Hname[j,] <- rank_df[rank_df$Rank == n[j] & rank_df$State == i,]
                } else {
                        Hname[j,] <- c("<NA>", i, "<NA>", "<NA>")
                }
                j <- j + 1
        }
        # set row names equal to state
        rownames(Hname) <- Hname[,2]
        colnames(Hname) <- c('hospital', 'state')
        Hname <- Hname[,1:2]
        return(Hname)
}