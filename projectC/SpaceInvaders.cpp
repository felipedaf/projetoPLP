#include <stdio.h>
#include <iostream>
#include <string>

using namespace std;


struct space_component {
    int hp;
    bool isEnemy; // sefor inimigo, hp eh 1, se nao 3
    bool isSpaceShip; //se for falso eh um tiro
};

space_component space[5][5];

void createSpaceShip(int i, int j, int hp, bool isEnemy, bool isSpaceShip) {
    space_component component;
    component.hp          = hp;
    component.isEnemy     = isEnemy;
    component.isSpaceShip = isSpaceShip;
    space[i][j] = component;
};

void buildSpace(){
    for(int i = 0; i < 5; i++){
        for(int j = 0; j < 5; j++){
            if (i < 2) {
                createSpaceShip(i, j, 1, true, true);
            } else if ( i == 4 && j == 2) {
                createSpaceShip(i, j, 3, false, true);
            }
        }   
    }
};

void menu(){
//    while (true){
 //          "A = Ir para esquerda \n
   //         D = Ir para direita  \n
     //       W = Atirar           \n
       //     S = Sair             \n");
    //}

};

int main(){
    buildSpace();
    for(int i = 0; i < 5; i++){
        for(int j = 0; j < 5; j++){
            cout << space[i][j].hp;
        }   
        cout << endl;
     }
    
};