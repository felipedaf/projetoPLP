#include <iostream>
#include <stdlib.h>
#include <stdio.h>
//#include <thread>
#include <unistd.h>
#include <curses.h>

using namespace std;

bool jogando, jogarDeNovo, ganhou = false;





struct Nave{
    int posicaoX;
    int vida;
};

struct Projetil{
    int posicaoX, posicaoY;
    bool acao;
    bool daNave;
};

struct Invasor{
    char corpo;
    int posicaoX, posicaoY;
};

int aproximacao, contadorDeMovimento = 0;
char matriz[40][64];
Invasor invasores[4][64];
Projetil projeteis[10];
Nave nave;

void iniciarProjeteis(int index){
    if(index == 0){
        return;
    }
    Projetil projetil;
    if(index % 2 == 0)
        projetil.daNave = true;
    else
        projetil.daNave = false;

    projetil.posicaoX = -1;
    projetil.posicaoY = -1;
    projetil.acao = false;
    projeteis[index] = projetil;
    iniciarProjeteis(index - 1);
}

void criaNave(){
    nave.posicaoX = 31;
    nave.vida = 3;
}

void criaInvasor(int x, int y, char corpo){
    Invasor invasor;
    invasor.posicaoX = x;
    invasor.posicaoY = y;
    invasor.corpo = corpo;

    invasores[y][x] = invasor;
}

void criarInvasores(){
    for(int i = 0; i < 4; i++){
        for(int j = 0; j < 64; j++){

            if(i == 3 and j >= 27 and j <= 37){
                criaInvasor(j, i, 'V');
            }
            else{
                criaInvasor(j, i, ' ');
            }

        }
    }
}


void criaTiro(){
    int posicaoX = nave.posicaoX;

    for(int i = 0; i < 10; i++){
        if(projeteis[i].posicaoX == -1 && projeteis[i].posicaoY == -1 && projeteis[i].daNave == true){
            projeteis[i].posicaoX = posicaoX;
            projeteis[i].posicaoY = 18;
            projeteis[i].acao = true;
            break;
        }

    }

}

void criaTiroInimigo(){
    contadorDeMovimento++;

    if(contadorDeMovimento % 3 == 0){
        int posicaoX = (rand() % 10) + 27;

        for(int i = 0; i < 10; i++){
        if(projeteis[i].posicaoX == -1 && projeteis[i].posicaoY == -1 && projeteis[i].daNave == false){
            projeteis[i].posicaoX = posicaoX;
            projeteis[i].posicaoY = 5;
            projeteis[i].acao = true;
            break;
        }

    }

    }

}

void criaEspaco(){
    for(int i = 0; i < 40; i++){
        for(int j = 0; j < 64; j++){
            if(i == 0 || i == 20){
                matriz[i][j] = 'x';
            }
            else if(j == 0 || j == 63){
                matriz[i][j] = 'x';
            }
            else{
                matriz[i][j] = ' ';
            }
        }
    }
}


void inserirInvasoresEmMatriz(){
    for(int i = 1; i < 4; i++){
        for(int j = 1; j < 63; j++){
            matriz[i][j] = invasores[i][j].corpo;
        }
    }
}

void inserirNaveEmMatriz(){
    matriz[19][nave.posicaoX] = 'A';
}

void inserirProjeteisEmMatriz(){
    for(int i = 0; i < 10; i++){
        if(projeteis[i].acao == true){
            matriz[projeteis[i].posicaoY][projeteis[i].posicaoX] = ':';
        }
    }
}



void moverNave(char comando){
    matriz[19][nave.posicaoX] = ' ';
    if(comando == 'a' && nave.posicaoX > 1){
        nave.posicaoX = nave.posicaoX - 1;
    }
    else if(comando == 'd' && nave.posicaoX < 62){
        nave.posicaoX = nave.posicaoX + 1;
    }
    else if(comando == 'w'){
        criaTiro();
    }
}


void checagemDeMovimento(){
    criaTiroInimigo();

    for(int i = 0; i < 10; i++){
        if(projeteis[i].posicaoX != -1 && projeteis[i].posicaoY != -1){
            if(projeteis[i].posicaoY <= 4 && (invasores[projeteis[i].posicaoY - 1][projeteis[i].posicaoX].corpo == 'V' || projeteis[i].posicaoY == 1)){
                invasores[projeteis[i].posicaoY - 1][projeteis[i].posicaoX].corpo = ' ';
                projeteis[i].acao = false;
                projeteis[i].posicaoX = -1;
                projeteis[i].posicaoY = -1;

            }
            else if(projeteis[i].posicaoY == 18 && projeteis[i].daNave == false){
                if(projeteis[i].posicaoX == nave.posicaoX){
                    nave.vida--;
                    if(nave.vida <= 0)
                        jogando = false;
                }
                projeteis[i].acao = false;
                projeteis[i].posicaoX = -1;
                projeteis[i].posicaoY = -1;

            }
            else if(projeteis[i].acao == true ){
                if(projeteis[i].daNave == true && projeteis[i].posicaoY > 0)
                    projeteis[i].posicaoY = projeteis[i].posicaoY - 1;
                else if(projeteis[i].daNave == false && projeteis[i].posicaoY < 22)
                    projeteis[i].posicaoY = projeteis[i].posicaoY + 1;

            }

        }
    }



    bool todosMortos = true;

    for(int i = 0; i < 4; i++){
        for(int j = 0; j < 64; j++){
            if(invasores[i][j].corpo == 'V')
                todosMortos = false;
        }
    }

    if(todosMortos){
        jogando = false;
        ganhou = true;
    }
}



void printComandos(){
    printf("(a) para a nave mover para a esquerda.        VIDAS: %d", nave.vida);
    printf("\n(d) para a nave mover para a direita.");
    printf("\n(w) para a nave atirar.\n");
}
void printMatriz(){
        system("clear");
        checagemDeMovimento();
        criaEspaco();
        inserirInvasoresEmMatriz();
        inserirNaveEmMatriz();
        inserirProjeteisEmMatriz();

        for(int i = 0; i < 21; i++){
            for(int j = 0; j < 64; j++){
                if(j == 63){
                    printf("%c\n", matriz[i][j]);
                }
                else{
                    printf("%c", matriz[i][j]);
                }
            }
        }
        printComandos();
}

void receberComando(char comando){
        if(comando == 'a' || comando == 'd'){
            moverNave(comando);
        }
        else if(comando == 'w'){
            criaTiro();
        }
}


int main()
{
    char escolha = ' ';
    int comando;

    while(escolha != 's'){
        if(jogarDeNovo){
            printf("\nVoce deseja jogar de novo ou sair? (j) - (s): ");
            scanf(" %c", &escolha);
        }
        else{
            printf("Voce deseja jogar ou sair? (j) - (s): ");
            scanf(" %c", &escolha);
        }
        jogarDeNovo = true;

        if(escolha == 'j'){
            jogando = true;
                iniciarProjeteis(9);
                criaNave();
                criarInvasores();
                system("clear");
                while(jogando){
                    initscr();
                    noecho();
                    cbreak();
                    escolha = getch();
                    endwin();
                    receberComando(escolha);
                    printMatriz();


                }

                system("clear");

                if(ganhou){
                    printf("Você ganhou o jogo!");
                }
                else{
                    printf("Você foi derrotado!");

                }

          //  }

        }
        else if(escolha == 's'){
            system("clear");
            printf("Saindo...");
        }
    }




}
