#include <stdio.h>
#include<iostream>
#include<string>

struct Utils() {
    string MENU; 
    MENU = "A = Ir para esquerda \n
            D = Ir para direita  \n
            W = Atirar           \n
            S = Sair             \n");

    string getMenu(){
        return MENU;
    }
}



struct SpaceInvaders(){
    Utils UResources;
    
    char entrada = input();

    while (entrada){

    }
    println(UResources.getMenu());

}

int main(){
    SpaceInvades game;
    game.
}