#include <stdio.h>
#include <SDL/SDL.h>

#define WIDTH 640
#define HEIGHT 480
#define DEPTH 24
#define STEPPING 10*WIDTH

SDL_Surface *screen;
int initialized = 0;

int counter = 0;

void setpixel(int x, int y, Uint8 r, Uint8 g, Uint8 b)
{
    int w=1;
    int h=1;
    Uint32 *pixmem32;
    Uint32 color;  
 
    color = SDL_MapRGB( screen->format, r, g, b );
  
 
SDL_Rect rect = {x,y,w,h};
SDL_FillRect(screen, &rect, color);
//FillRect(25,25,100,150,0xFFFFFF);
//SDL_UpdateRect(screen, x, y, w, h);


if(counter++>=STEPPING)  {
	SDL_Flip(screen);
	counter =0;
}



}



void handle_data(int address, int value) {
if(!initialized) init();

//printf("Writing %x to %x\n", value, address);


int x = address%WIDTH;
int y = address/WIDTH;

if(y>HEIGHT)
return ;

Uint8 r = value;
Uint8 g = value >> 8;
Uint8 b = value >> 16;
//r=255;
//g=255;
//b=255;

setpixel(x, y, r, g, b);
//SDL_Flip();



}






int init ()
{

initialized = 1;
  

  
    if (SDL_Init(SDL_INIT_VIDEO) < 0 ) return 1;
   
    if (!(screen = SDL_SetVideoMode(WIDTH, HEIGHT, DEPTH, SDL_SWSURFACE)))
    {
        SDL_Quit();
        return 1;
    }
    return 0;
}

/*
int main() {
init();
setpixel(100, 100, 255, 255,255);
setpixel(101, 100, 0  , 255,255);
setpixel(102, 100, 255, 0  ,255);
setpixel(103, 100, 255, 255,0  );

    SDL_Event event;
    int keypress = 0;
while(!keypress) 
    {
         while(SDL_PollEvent(&event)) 
         {      
              switch (event.type) 
              {
                  case SDL_QUIT:
	              keypress = 1;
	              break;
                  case SDL_KEYDOWN:
                       keypress = 1;
                       break;
              }
         }
    }

    SDL_Quit();

}
*/


