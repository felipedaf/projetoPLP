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
    bool isShot;
};

space_component space[5][5];

void createSpaceComponent(int i, int j, int hp, bool isEnemy, bool isSpaceShip, bool isVacuo, bool isShot) {
    space_component component;
    component.hp          = hp;
    component.isEnemy     = isEnemy;
    component.isSpaceShip = isSpaceShip;
    component.isVacuo     = isVacuo;
    component.isShot      = isShot;
    space[i][j] = component;
};

void buildSpace(){
    for(int i = 0; i < 5; i++){
        for(int j = 0; j < 5; j++){
            if (i < 2) {
                createSpaceComponent(i, j, 1, true, true, false, false); //inimiga
            } else if ( i == 4 && j == 2) {
                createSpaceComponent(i, j, 3, false, true, false, false); //jogador
            } else {
                createSpaceComponent(i, j, 0, false, false, true, false); //vacuo
            } 
        }   
    }
};

string toString(space_component component) {
    if (component.isVacuo){
        return "   ";    
    } else if (component.isShot && component.isEnemy) {
        return " v ";
    } else if (component.isShot && !component.isEnemy) {
        return " ^ ";
    } else if (component.isSpaceShip && component.isEnemy){
        return " V ";
    } else if (component.isSpaceShip && !component.isEnemy) {
        return " A ";
    }
};

int getShipPosition(){
    for(int j = 0; j < 5; j++){
        if (!space[4][j].isEnemy && space[4][j].isSpaceShip){
            return j;
        } 
    } return 0; 
};

int moveShot(){
    for(int i = 0; i < 5; i++){
        for(int j = 0; j < 5; j++){
            if (space[i][j].isShot && !space[i][j].isEnemy){
                if (space[i-1][j].isSpaceShip && space[i-1][j].isEnemy){
                    createSpaceComponent(i, j, 0, false, false, true, false); //colocando o vacuo           
                    createSpaceComponent(i-1, j, 0, false, false, true, false); //colocando o vacuo  
                } else {
                    createSpaceComponent(i, j, 0, false, false, true, false); //colocando o vacuo           
                    createSpaceComponent(i-1, j, 0, false, false, false, true); //colocando o tiro  
                    break;  
                }       
            }     
        }   
    }
};

void moveSpaceShip(bool left){
    int hpPlayerShip = space[4][getShipPosition()].hp;
    int positionPlayerShip = getShipPosition();

    for (int j = 0; j < 5; j++) {
        if (left && positionPlayerShip != 0) {
            createSpaceComponent(4, positionPlayerShip, 0, false, false, true, false); //colocando o vacuo           
            createSpaceComponent(4, positionPlayerShip - 1, hpPlayerShip, false, true, false, false); //atualiza posicao nave player 
        } else if (!left && positionPlayerShip != 4){
            createSpaceComponent(4, positionPlayerShip, 0, false, false, true, false); //colocando o vacuo           
            createSpaceComponent(4, positionPlayerShip + 1, hpPlayerShip, false, true, false, false); //atualiza posicao nave player 
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
    cout << "HP : " << space[4][getShipPosition()].hp << endl;
};

void shot(){
    int positionPlayerShip = getShipPosition();
    createSpaceComponent(3, positionPlayerShip, 2, false, false, false, true); //tiro           
}

void menu(){
    while (true){
        system("clear");
        printGame();
        string option;
        cout << "a = Ir para esquerda" << endl;
        cout << "d = Ir para direita" << endl;
        cout << "w = Atirar" << endl;
        cout << "s = Sair" << endl;
        cin >> option;
        bool left = true;

        if (option == "a") {
            moveShot();
            moveSpaceShip(left);            
        } else if (option == "d") {
            moveShot();
            moveSpaceShip(!left);
        } else if (option == "w") {
            moveShot();
            shot();
        } else if (option == "s") {
            break;
        }
    }
};

int main(){
    buildSpace();
    menu();
    printGame();
};