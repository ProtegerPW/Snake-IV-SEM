#include <stdio.h>
#include </usr/local/include/SDL2/SDL.h>
#include "x86_function.h"
#include "f.h"

int main(int argc, char* argv[]) {
    srand (time(NULL));

    //inicialize snakeData
    int32_t snakeBytes[400] = {};
    generateSnake(snakeBytes);
    int32_t direction = 2;
    int32_t snakeHead = 8;
    int32_t snakeTail = 0;

    //inicialize fruitData
    int32_t snakeFruit[3] = {0, 0, 0};
    generateFruit(snakeFruit, snakeBytes, snakeHead, snakeTail);
    
    /* setttings use to configure GUI part */
    SDL_Window *background;
    SDL_Renderer *renderer;
    SDL_Renderer *rendererError;
    if(SDL_Init(SDL_INIT_VIDEO) < 0){
        return 1;
    }

    background = SDL_CreateWindow("~~Snake Game~~", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 440, 440, SDL_WINDOW_OPENGL);
    renderer = SDL_CreateRenderer(background, -1, 0);
    rendererError = SDL_CreateRenderer(background, -1, 0);

    /*inicialize and color board of rectangles to display snake board */
    SDL_Rect board[20][20];
    for(int i = 0; i < 20; i++) {
        for (int j = 0; j < 20; j++) {
            board[i][j] = newSDL_Rect(20 + i * 20, 20 + j * 20, 19, 19);
            SDL_SetRenderDrawColor(renderer, 212, 175, 55, 255);
            SDL_RenderFillRect(renderer, &board[i][j]);
        }
    }
    drawSnake(snakeBytes, board, renderer);
    drawFruit(snakeFruit, board, renderer);
    

    SDL_Event event;
    int done = 0;
    // /****** GAME LOOOP ******/
    while (!done) {

        while(SDL_PollEvent(&event)){
            if(event.type == SDL_QUIT){
                done = 1;
            }
        }
        /* part for input service */
        const Uint8 *state = SDL_GetKeyboardState(NULL);
            if(state[SDL_SCANCODE_W] && direction != DOWN){
                direction = UP;
            }
            if(state[SDL_SCANCODE_S] && direction != UP){
                direction = DOWN;
            }
            if(state[SDL_SCANCODE_A] && direction != RIGHT){
                direction = LEFT;
            }
            if(state[SDL_SCANCODE_D] && direction != LEFT){
                direction = RIGHT;
            }
            if(state[SDL_SCANCODE_E]) {
                done = 1;
                SDL_DestroyWindow(background);
                SDL_Quit();
            }
        /* the star of the show */
        x86_function(snakeBytes, direction, &snakeHead, &snakeTail, snakeFruit); 
        
        int i = snakeHead;
        if(snakeBytes[i] == 30) {
            // SDL_SetRenderDrawColor(rendererError, 255, 0, 0, 255);
            // SDL_RenderClear(renderer);
            // SDL_RenderClear(rendererError);
            // SDL_Rect r;
            // r.x = 170;
            // r.y = 0;
            // r.w = 100;
            // r.h = 100;
            // SDL_SetRenderDrawColor(rendererError, 255, 0, 0, 255);
            // SDL_RenderFillRect( rendererError, &r);
            // SDL_RenderPresent(rendererError);
            // SDL_UpdateWindowSurface(background);
            printf(" You lost! \n");
            SDL_Delay(5000);
            SDL_DestroyWindow(background);
            SDL_Quit();
            return 0;
        }
        SDL_SetRenderDrawColor(renderer, 0, 175, 0, 255);
        SDL_RenderFillRect(renderer, &board[snakeBytes[i]][snakeBytes[i+1]]);
        
        //draw raw pixel behind a snake
        if(snakeTail == 0) {
            SDL_SetRenderDrawColor(renderer, 212, 175, 55, 255);
            SDL_RenderFillRect(renderer, &board[snakeBytes[398]][snakeBytes[399]]);
        } else {
            SDL_SetRenderDrawColor(renderer, 212, 175, 55, 255);
            SDL_RenderFillRect(renderer, &board[snakeBytes[snakeTail-2]][snakeBytes[snakeTail-1]]);
        }
        // draw fruit 
        if(snakeFruit[0] == 1) {
            snakeFruit[0] = 0;
            generateFruit(snakeFruit, snakeBytes, snakeHead, snakeTail);
            SDL_SetRenderDrawColor(renderer, 255, 0, 0, 255);
            SDL_RenderFillRect(renderer, &board[snakeFruit[1]][snakeFruit[2]]);
        }

        SDL_RenderPresent(renderer);
        SDL_UpdateWindowSurface(background);      
        SDL_Delay(SPEED); //set GameSpeed 
    }
    return 0;
}
