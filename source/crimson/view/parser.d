module crimson.view.parser;

//{{ aVarToShow }}

import std.string;
import std.algorithm;
import std.array;
import std.stdio;


import crimson.view.tokenizer; 

class ParserInterface {
    
}

class Parser : ParserInterface {
    private:
        Tokenizer tokenizer;
        string[string] meta;
        string[string] variables;

    public this(string data, string[string] variables = null) {
        this.tokenizer = new Tokenizer(data);

        if(variables != null) {
            this.variables = variables;
        } 
    }

    public string getOutput() {
        string[] tokens = this.tokenizer.getTokens();
        string[] allTokens;

        foreach(int i, string token; tokens) {
            if(token != "" && token != " ") {
                allTokens ~= token;
            }
        }

        return allTokens.join(" ");
    }

    public void parse() {
        while(!this.tokenizer.isEnd()) {
            string token = this.tokenizer.getToken();

            //Start of tag operations
           if(token == "T_TAG_OPEN") {

               this.tokenizer.consume();

               this.tokenizer.next();
                string nextToken = this.tokenizer.consume();
                

                if(nextToken == "T_TAG_OPEN") {
                    //parse var
                    this.tokenizer.next();
                    string varName = this.tokenizer.consume();

                    this.tokenizer.replace(this.variables[varName.chomp(" ")]);

                    //end brackets
                    this.tokenizer.next();
                    this.tokenizer.consume();

                    this.tokenizer.next();
                    this.tokenizer.consume();
                }

                else {
                    throw new Exception("Parse Error: Invalid token found after T_TAG_OPEN");
                }

            }
            
            this.tokenizer.next();
        }
    }
}
