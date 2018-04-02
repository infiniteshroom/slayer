module slayer.fastcgi;

//Bare bones skeleton for boostraping a dlang fastcgi interface by mark j. lang
extern(C) int FCGX_Init();
extern(C) int FCGX_InitRequest(FCGX_Request* request, int sock = 0, int flags = 0);
extern(C) int FCGX_Accept_r(FCGX_Request*);
extern(C) void FCGX_Finish_r(FCGX_Request *request);

extern(C) int FCGX_FPrintF(FCGX_Stream *stream, const char *format, ...);
extern(C) char* FCGX_GetParam(const char* name, char** envp);

struct FCGX_Stream {
    ubyte* rdNext;    
                              
    ubyte* wrNext;    
                            
    ubyte* stop;     
                         
    ubyte* stopUnget; 
                              
                              
    int isReader;
    int isClosed;
    int wasFCloseCalled;
    int FCGI_errno;   
    
    void* fillBuffProc;
    void *emptyBuffProc;
    void *data;
}

struct Params {
    char** vec;
    int length;
    char** cur;
}


struct FCGX_Request {
    public:
        int requestId;
        int role;

        FCGX_Stream* _in;
        FCGX_Stream* _out;
        FCGX_Stream* _err;
        char** envp;

    private:
        Params* paramsPtr;
        int ipcFd;
        int isBeginProcessed;
        int keepConnection;
        int appStatus;
        int nWriters;
        int flags;
        int listen_sock;
}
