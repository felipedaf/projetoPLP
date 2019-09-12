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

void createSpaceShip(int i, int j, int hp, bool isEnemy, bool isSpaceShip) {
    space_component component;
    component.hp          = hp;
    component.isEnemy     = isEnemy;
    component.isSpaceShip = isSpaceShip;
    space[i][j] = component;
};


string toString(space_component component) {
    if(component.isSpaceShip && component.isEnemy){
        return " V ";
    } else if (component.isSpaceShip && !component.isEnemy) {
        return " A ";
    } else if (!component.isSpaceShip && component.isEnemy) {
        return " v ";
    } else if (component.hp == 0) {
        return "   ";
    } else if (!component.isSpaceShip && !component.isEnemy) {
        return " ^ ";
    }
};

int getPlayerPosition(){
    for(int j = 0; j < 5; j++){
        if (space[4][j].hp == 3){
            return j;
        } 
    } return 0; 
};

void move(bool left){
    if (!left && (getPlayerPosition() != 4)){
        space[4]
    }
};

void shot(){
    for ()

};

void menu(){
    while (true){
        cout << "A = Ir para esquerda" << endl;
        cout << "D = Ir para direita" << endl;
        cout << "W = Atirar" << endl;
        cout << "S = Sair" << endl;
        cin << option;

    if (option == "W"){
            
    }

    }
};

void printGame() {
    for(int i = 0; i < 5; i++){
        for(int j = 0; j < 5; j++){
            cout << toString(space[i][j]);
        }   
        cout << endl;
     }
};


int main(){
    buildSpace();
    printGame();
};