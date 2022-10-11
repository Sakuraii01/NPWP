module checkLogic(){
    if(01 == 1){
        if(btnDown || btnLeft || btnUp){
            reset;
        }
    }
    if(02 == 1){
        if(btnDown || btnUp){
            reset;
        }
    }
    if(03 == 1){
        if(btnUp || btnRight)
            reset;
    }
    if(04 == 1){
        if(btnLeft || btnUp){
            reset;
        }
    }
    if(05 == 1){
        if(btnUp || btnRight){
            reset;
        }
    }
}