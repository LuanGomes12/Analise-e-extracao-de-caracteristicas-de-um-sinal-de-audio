% ********** Luan Gomes Magalhães Lima - 473008 ********** 
% ********** Prática 1                          **********

% Inicializações
clear all;
close all;
clc;

%% Questão 1
[y fs] = audioread("audio.aac");
t = 1:length(y);
y = y(:, 1);

% Plotagem do sinal de áudio
figure,plot(t, y);
title('Sinal de áudio [1]');
xlabel('Tempo');
ylabel('Amplitude do sinal');

%% Questão 2
sound(y, fs);

%% Questão 3
n_barras = 100;
figure, histogram(y, n_barras);
title('Histograma do Sinal [2]');
xlabel('Amostras');
ylabel('Frequência Relativa');

%% Questão 4
% Assimetria
assim = skewness(y);
figure, histogram(y, n_barras); 
hold on, line([mean(y) mean(y)], ylim, 'Color', 'r', 'LineWidth', 2); % Plotagem
                                % da média sobre o histograma, para efeitos
                                % comparativos
title('Plotagem da média [3]');
xlabel('Amostras');
ylabel('Frequência Relativa');

% Plotagem da assimetria
fprintf('Assimetria: %f\n', assim);
fprintf('\n');

% Com base no valor da assimetria (0.24) mostrado na variável "assim" 
% observa-se que ela está bem próxima de zero, isso poderia indicar uma 
% distribuição simétrica dos valores em torno da média, contudo levando em
% consideração a escala dos valores bem baixa evidencia-se que o sinal não
% é simétrico, principalmente por se tratar de um sinal de aúdio. Isso
% também pode ser visto e comprovado, na plotagem da Figura [3], na qual 
% a média do sinal é plotada no histograma, com isso podemos concluir que 
% existem muitos valores que se destoam da média.

curtose = kurtosis(y);
figure, normplot(y); % Figura [4]

% Plotagem da curtose
fprintf('Curtose: %f\n', curtose);
fprintf('\n');

% Com base no valor da curtose (3.35) observa-se que esse valor é maior que
% 3, com isso essa distribuição é chamada de leptocúrtica, possui caudas
% mais pesadas, isso mostra que é relativamente fácil obter valores que não
% se aproximam da média, conforme pode ser visto na Figura [3] e [4], isso
% também se deve ao fato do sinal de áudio possuir inúmeras amostras que se
% divergem umas das outras, logo essa distribuição faz sentido.

%% Questão 5
% Excluir os 512 últimos elementos do sinal original, para dividir o sinal
% igualmente em 12 partes de 5000 elementos em cada parte
y = y(1:end-512);
partes = reshape(y, 5000, 12); 

% Média de cada parte do sinal
M = zeros(12,1);
for i = 1:12
    M(i, 1) = mean(partes(:,i));
    fprintf('Media %d: %f\n', i, M(i, 1));
end
fprintf('\n');

% Conforme pode ser visto no prompt de comando a média varia com o tempo e
% não é constante, isso era de se esperar por se tratar de um sinal de
% áudio, no qual as amostras não são iguais umas das outras, ou seja, no
% sinal de áudio pode haver variações significativas em diferentes partes
% do sinal. Vale ressaltar que existe a possibilidade dessas médias
% temporais serem constantes desde que intervalos cada vez menores sejam
% utilizados para efeitos comparativos.

%% Questão 6
% Autocorrelação de cada parte do sinal
R = zeros(31, 12);
for j = 1:12
    R(:, j) = autocorr(partes(:, j), 30);
end

% Mostra os valores da Matriz de Autocorelação
fprintf('\nMatriz de Autocorrelação:');
disp(R);

% Conforme pode ser visto no prompt de comando os valores de autocorrelação
% não são constante pois variam com o tempo e não apenas com o delay, essa
% dependência temporal torna a autocorrelação não constante, isso também 
% era de se esperar devido os motivos citados anteriormente, no qual mencionam
% o caráter e forma de um sinal de áudio. Cada coluna do vetor R representa
% a autocorrelação de cada parte do sinal.

%% Questão 7
% Para um sinal ser estacionário no sentido amplo (WSS) é necessário que as 
% suas estatísticas permaneçam constantes ao longo do tempo, ou seja, a 
% média temporal e autocorrelação devem permanecer constantes, como mostrado 
% nas questões anteriores isso não é verdade, logo, o sinal não é 
% estacionário no sentido amplo. Vale ressaltar que um sinal pode ser
% estacionário no sentido amplo pegando apenas amostras bem pequenas dele,
% contudo o tamanho das amostras escolhidas não foram suficientes para
% mostrar que em dado intervalo o sinal é WSS.