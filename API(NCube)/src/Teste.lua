   function teste(a) 
     error("my error"..a) 
    end
   
   
   
   
   
   local status, err = pcall(teste, 9)
    print(err)
      
      local a, b, c;
      
      print(a)
      print(b)
      print(c)