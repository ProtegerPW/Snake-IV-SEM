#ifndef F_H
#define F_H
#include </usr/local/include/SDL2/SDL.h>

#define UP 1
#define DOWN 2
#define LEFT 3
#define RIGHT 4
#define BOARD_SIZE 20*20
#define BOARD_LENGTH 20
#define SPEED 300

SDL_Rect newSDL_Rect(int xPoint, int yPoint, int width, int height) {
    SDL_Rect rectangular;
    rectangular.x = xPoint;
    rectangular.y = yPoint;
    rectangular.w = width;
    rectangular.h = height;
    return rectangular;
}

void generateSnake(int32_t* snakeBytes) {
    int32_t y = rand() % 10 + 5;
    int32_t x = rand() % 20;
    for(int i = 8; i >= 0; i-=2) {
        snakeBytes[i] = x;
        snakeBytes[i+1] = y;
        --y;
    }
}

void drawSnake(int* snakeBytes, SDL_Rect board[BOARD_LENGTH][BOARD_LENGTH], SDL_Renderer* renderer) {
    for(int i = 0; i <= 8; i+=2) {
        SDL_SetRenderDrawColor(renderer, 0, 175, 0, 255);
        SDL_RenderFillRect(renderer, &board[snakeBytes[i]][snakeBytes[i+1]]);
    }
}

void generateFruit(int* snakeFruit, int* boardSnake, int snakeHead, int snakeTail) {
    int yFruit = rand() % 20;
    int xFruit = rand() % 20;
    int tempSnakeTail = snakeTail;
    while(snakeTail != snakeHead + 2) {
        if(xFruit == boardSnake[snakeTail] && yFruit == boardSnake[snakeTail+1]) {
            xFruit = rand() % 20;
            yFruit = rand() % 20;
            snakeTail = tempSnakeTail;
        }
        snakeTail += 2;
        if(snakeTail == 400) {
            snakeTail = 0;
        }
    }
    snakeFruit[1] = xFruit;
    snakeFruit[2] = yFruit;
}

void drawFruit(int* snakeFruit, SDL_Rect board[BOARD_LENGTH][BOARD_LENGTH], SDL_Renderer* renderer) {
        SDL_SetRenderDrawColor(renderer, 255, 0, 0, 255);
        SDL_RenderFillRect(renderer, &board[snakeFruit[1]][snakeFruit[2]]);
}

#endif