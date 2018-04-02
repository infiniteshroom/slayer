module crimson.view.tokenizer;

import std.string;
import std.conv;
import std.array;
import std.regex;
import std.stdio;

enum TokenizerTokens {
    T_TAG_OPEN = "{",
    T_TAG_CLOSE = "}",
    T_TAG_OPERATION = "%"
}

interface TokenizerInterface {
    void replace(string data, int pos=-1);
    void next();
    void prev();
    void forward(int amount=-1);
    void setCurrentPos(int pos);
    string getToken(int pos=-1);
    int getCurrentPos();
    string[] getTokens();
    string consume();
    bool isEnd();
}

class Tokenizer : TokenizerInterface {
    private: 
        string[] tokens;
        int pos = 0;

    

    public this(string data) {
        this.tokens = this.buildParseTree(data);
    } 

    private string[] buildParseTree(string data) {
        data = data.replace("{", " T_TAG_OPEN ");
        data = data.replace("}", " T_TAG_CLOSE ");
        data = data.replace(to!string(TokenizerTokens.T_TAG_OPERATION), "T_TAG_OPERATION");

        string[] tokens = data.split(" ");

        string[] allTokens;

        foreach(int i, string token; tokens) {
            if(token != "" && token != " ") {
                allTokens ~= token;
            }
        }

        return allTokens;
    } 

    public string consume() {
        string token = this.getToken();

        this.tokens[this.pos] = "";

        return token;
    }

    public bool isEnd() {
        if(this.pos != this.tokens.length - 1) {
            return false;
        }

        else {
            return true;
        }
    }

    public string[] getTokens() {
        return this.tokens;
    }    

    public void replace(string data, int pos=-1) {

        if(pos == -1) {
            pos = this.pos;
        }
      /*  string[] firstHalf = this.tokens[0 .. pos];

        foreach(int i, char item;data) {
            firstHalf ~= to!string(item);
        }

        string[] secondHalf = this.tokens[pos + 1 .. $];

        //add second half to first half
        foreach(string item; secondHalf) {
            firstHalf ~= item;
        }

        string[] completeTokens = firstHalf;*/

        this.tokens[pos] = data;

        
    }

    public void next() {
        this.pos++;
    }

    public void prev() {
        this.pos--;
    }

    public void forward(int amount=-1) {
        if(amount == -1) {
            this.next();
        }

        else {
            this.pos += amount;
        }
    }

    public void setCurrentPos(int pos) {
        this.pos = pos;
    }

    public string getToken(int pos=-1) {

    
        if(pos == -1) {
            return this.tokens[this.pos];
        }

        else {
            return this.tokens[pos];
        }
    }


    public int getCurrentPos() {
        return this.pos;
    }
}