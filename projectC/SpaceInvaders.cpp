#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <string>

using namespace std;

struct space_component {
    int hp;
    bool isEnemy; // sefor inimigo, hp eh 1, se nao 3
    bool isSpaceShip; //se for falso eh um tiro
    bool isVacuo;
};

space_component space[5][5];

void createSpaceComponent(int i, int j, int hp, bool isEnemy, bool isSpaceShip, bool isVacuo) {
    space_component component;
    component.hp          = hp;
    component.isEnemy     = isEnemy;
    component.isSpaceShip = isSpaceShip;
    component.isVacuo     = isVacuo;
    space[i][j] = component;
};

void buildSpace(){
    for(int i = 0; i < 5; i++){
        for(int j = 0; j < 5; j++){
            if (i < 2) {
                createSpaceComponent(i, j, 1, true, true, false); //inimiga
            } else if ( i == 4 && j == 2) {
                createSpaceComponent(i, j, 3, false, true, false); //jogador
            } else {
                createSpaceComponent(i, j, 0, false, false, true); //vacuo
            } 
        }   
    }
};



string toString(space_component component) {
    if (component.isVacuo){
        return "   ";    
    } else if(component.isSpaceShip && component.isEnemy){
        return " V ";
    } else if (component.isSpaceShip && !component.isEnemy) {
        return " A ";
    } else if (!component.isSpaceShip && component.isEnemy) {
        return " v ";
    } else if (!component.isSpaceShip && !component.isEnemy) {
        return " ^ ";
    }
};

int getPlayerPosition(){
    for(int j = 0; j < 5; j++){
        if (!space[4][j].isEnemy && space[4][j].isSpaceShip){
            return j;
        } 
    } return 0; 
};

void move(bool left){
    int hpPlayerShip = space[4][getPlayerPosition()].hp;
    int positionPlayerShip = getPlayerPosition();

    for (int j = 0; j < 5; j++) {
        if (left && positionPlayerShip != 0) {
            createSpaceComponent(4, positionPlayerShip, 0, false, false, true); //colocando o vacuo           
            createSpaceComponent(4, positionPlayerShip - 1, hpPlayerShip, false, true, false); //atualiza posicao nave player 
        } else if (!left && positionPlayerShip != 4){
            createSpaceComponent(4, positionPlayerShip, 0, false, false, true); //colocando o vacuo           
            createSpaceComponent(4, positionPlayerShip + 1, hpPlayerShip, false, true, false); //atualiza posicao nave player 
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

void menu(){
    while (true){
        system("clear");
        printGame();
        string option;
        cout << "A = Ir para esquerda" << endl;
        cout << "D = Ir para direita" << endl;
        cout << "W = Atirar" << endl;
        cout << "S = Sair" << endl;
        cin >> option;
        bool left = true;

        if (option == "A") {
            move(left);            
        } else if (option == "D") {
            move(!left);
        } else {
            break;            
        }
    }
};


int main(){
    buildSpace();
    menu();
    printGame();
};