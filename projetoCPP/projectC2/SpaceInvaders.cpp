#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <string>
#include <unistd.h>
#include <thread>
#include <cstdlib>

using namespace std;

struct space_component {
    int hp;
    bool isEnemy; 
    bool isSpaceShip; 
    bool isVacuo;
    bool isShot;
};

space_component space[30][30];

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
    for(int i = 0; i < 30; i++){
        for(int j = 0; j < 30; j++){
            if (i < 2) {
                createSpaceComponent(i, j, 1, true, true, false, false); //inimiga
            } else if ( i == 29 && j == 15) {
                createSpaceComponent(i, j, 1, false, true, false, false); //jogador
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
    for(int j = 0; j < 30; j++){
        if (!space[29][j].isEnemy && space[29][j].isSpaceShip){
            return j;
        } 
    } return 0; 
};

int moveShot(){
    for(int i = 0; i < 30; i++){
        for(int j = 0; j < 30; j++){
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
//bool isEnemy, bool isSpaceShip, bool isVacuo, bool isShot
void moveEnemyShot(){
    for(int i = 29; i>=0; i--){
        for(int j = 29; j>=0; j--){
            if(space[i][j].isShot && space[i][j].isEnemy){
                if(space[i+1][j].isSpaceShip && !space[i+1][j].isEnemy){
                     createSpaceComponent(i, j, 0, false, false, true, false); //colocando o vacuo         e retira a nave    
                     createSpaceComponent(i+1, j, 0, false, false, true, false); //colocando o vacuo         e retira a nave    
                     createSpaceComponent(i+1, j, 0, false, true, false, false);  


                     }
                else{
                    createSpaceComponent(i ,j ,0 ,false ,false ,true ,false);
                    createSpaceComponent(i+1, j, 1, true, false, false, true);
                }
            }
        }
    }
}

void moveSpaceShip(bool left){
    int hpPlayerShip = space[29][getShipPosition()].hp;
    int positionPlayerShip = getShipPosition();

    for (int j = 0; j < 30; j++) {
        if (left && positionPlayerShip != 0) {
            createSpaceComponent(29, positionPlayerShip, 0, false, false, true, false); //colocando o vacuo           
            createSpaceComponent(29, positionPlayerShip - 1, hpPlayerShip, false, true, false, false); //atualiza posicao nave player 
        } else if (!left && positionPlayerShip != 29){
            createSpaceComponent(29, positionPlayerShip, 0, false, false, true, false); //colocando o vacuo           
            createSpaceComponent(29, positionPlayerShip + 1, hpPlayerShip, false, true, false, false); //atualiza posicao nave player 
        }
    }
};

void printGame() {
    for(int i = 0; i < 30; i++){
        for(int j = 0; j < 30; j++){
            cout << toString(space[i][j]);
        }   
        cout << endl;
     }
    cout << "HP : " << space[29][getShipPosition()].hp << endl;
};

void shot(){
    int positionPlayerShip = getShipPosition();
    createSpaceComponent(28, positionPlayerShip, 2, false, false, false, true); //tiro           
}

void enemyShot(){
    int enemy = rand()%29;
    int i = 2;
    if(space[i][enemy].isEnemy && space[i][enemy].isSpaceShip){
        createSpaceComponent(i+1, enemy, 7, true, false, false, true);
    }else if(space[i-1][enemy].isEnemy && space[i-1][enemy].isSpaceShip){
        createSpaceComponent(i+1, enemy, 7, true, false, false, true);
    }
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
        cin  >> option;
        bool left = true;

        if (option == "a") {
            moveSpaceShip(left);            
            //moveEnemyShot();
            //moveShot();

        } else if (option == "d") {
            //    moveEnemyShot();
            //moveShot();
            moveSpaceShip(!left);
        } else if (option == "w") {
            //moveEnemyShot();
            //moveShot();
            shot();
        } else if (option == "s") {
            break;
        }
        enemyShot();
        
    }
};

void nextFrame(){
    while (true)
    {
        system("clear");
        printGame();
        cout << "a = Ir para esquerda" << endl;
        cout << "d = Ir para direita" << endl;
        cout << "w = Atirar" << endl;
        cout << "s = Sair" << endl;
        
        moveEnemyShot();
        moveShot();
        
        usleep(600000);
    }
}

int main(){
    buildSpace();
    thread t1(menu);
    thread t2(nextFrame);
    if(t1.joinable()){
        t1.join();
    }
    if(t2.joinable()){
        t2.join();
    }
    
    printGame();
};