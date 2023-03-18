function $(selector){

    //let self=document.querySelector(selector);
    //object literal

    const self = { 
       elm: document.querySelector(selector),
       html: () => self.elm.innerHTML,
       text: () => { return self.elm.innerText; },
       on: (e,cb) => {
           document.addEventListener(e,cb);
           return self;
       },
       hide: () => {
           self.elm.style.display="none";
           return self;
        },
       show: () => {
            self.elm.style.display="";
            return self;
        },
       attr: (name, value) => {
           
           if (value==null){
               //console.log(name,self.elm.getAttribute(name));
               //self.elm.getAttribute(name);
               return self.elm.getAttribute(name);
              // return self;
           }else{
               self.elm.setAttribute(name,value);
               return self;
           }
       }, 
       val: () => self.elm.value,

       serialize: () => {

            console.dir(self.elm.elements);
            for(let i=0; i<self.elm.elements.length;i++){

                var element=self.elm.elements[i];
                //console.log(`${element.nodeName}-${element.nodeType}-${element.name}-${element.tagName}-${element.type}-${element.value}`);
                //console.dir(element.nodeName);
            }
            console.log(typeof self.elm.elements); //object == HTMLFormControlsCollection

       },
       formData: () => {

            var fdata = new FormData();
            for(let i=0; i<self.elm.elements.length;i++){

                var element=self.elm.elements[i];
                let etype=element.type;

                if (etype=='file'){
                    //console.log(element.multiple, element.files);
                    for(let file of element.files){
                        //console.log(file);
                        fdata.append('files',file,file.name);
                    }
                    
                }else if(etype=='text'){
                    fdata.append(element.name,element.value);

                }else if(etype=='radio'){
                    //console.log(element.name,element.checked,element.value);
                    if (element.checked){
                        fdata.append(element.name,element.value);
                    }

                }else if(etype=='checkbox'){
                    //console.log(element.name, element.checked, element.value);
                    if (element.checked){
                        fdata.append(element.name,element.value);
                    }

                }else if(etype=='textarea'){
                    fdata.append(element.name,element.value);

                }else if(etype=='select'){
                    //console.log('*',element.name,element.value);
                    fdata.append(element.name,element.value);
                }
                //console.log(`${element.nodeName}-${element.nodeType}-${element.name}-${element.tagName}-${element.type}-${element.value}-${element.multiple}`);
            }
            return fdata;
       },
       formSubmit: async (url,fdata) => {

            try{
                const res = await fetch(url, {method:"POST", mode:'cors', body: fdata});
                const data = await res.json();
        
                if (!res.ok){
                    console.log(data.description);
                    return;
                }
                //console.log(data);
                return data;

            } catch(error) {
                console.log(error);
            }

       },

       css: (object) => {

        //console.log(typeof styles); //object
        console.log(object);
        for(let key in object){
            //console.log(key, object[key]);
            self.elm.style[key]=object[key];
        }
        return self; //for chaining
       },

    }
    

    // self.text = function(){
    //     return self.innerText.innerText;
    // }
     return self;
   }