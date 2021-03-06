/*
Nate Mara
2013-10-12

"Space Invaders"

This program A *very* barebones version of the game "Space Invaders" . 
I currently have not implimented any actual game mechanics, like score 
or shot collisions with enemies, but it's a WIP.

*/

// Triggers a user can change
boolean isSpaceInvaders = true;
int textStartY = 720/2;
final int textLineSpacing = 30;
final int shotSpeed = 9;
int sStartY = 100;
int sStartX = 75;
int sDeltaY = 75;

// Variables that the program uses
boolean shotExists = false;
int shotX;
int score = 0;
int playerPosX;
int playerPosY;
int shotY;

// Loads outside resources (image and font)
PFont pixelFont;
PImage roof;

// Arrays that store positions of the Invaders
int[] row1X = new int[11];
int[] row2X = new int[11];
int[] row3X = new int[11];
int[] row4X = new int[11];
int[] row5X = new int[11];

int[] row1Y = new int[11];
int[] row2Y = new int[11];
int[] row3Y = new int[11];
int[] row4Y = new int[11];
int[] row5Y = new int[11];

void setup() {
	pixelFont = loadFont("Courier.vlw");
	roof = loadImage("roof.png");

	size(651, 744);
	FormatText();
	SpaceInvaderChecker();
	noStroke();
}

void draw(){
	background(0);
	CreatePlayer(mouseX, height - 100);
	ShotChecker();
	RenderGUI();
	makeSIArray();
	DrawSIArray();
	DrawRoofs();
	FuckAllShow();
}

void SpaceInvaderChecker() {
	/*
	Checks to see if the user was bold enough to change the 
	"isSpaceInvaders" boolean value
	*/

	if (!isSpaceInvaders) {
		TextLine("Well look at you, messing with source code, thinking you\'re soooo great.", -1);
		TextLine("Tell me, what exactly did you think would happen,", 0);
		TextLine("When you changed the value of \"isSpaceInvaders\" from true to false?", 1);
		TextLine("Did you think that PacMan would start?", 2);
	}
}

void TextLine(String inputText, int inputLine) {
	/*
	Prints "inputText" at the "inputLine" line. (line is an arbitrary
	Y coordinate based on the "textStartY" and "textLineSpacing" variables)
	*/
	int textLine = textStartY + (inputLine - 1) * textLineSpacing;
	text(inputText, width/2, textLine);
}

void FormatText() {
	/*
	Adds formatting to text
	*/
	textAlign(CENTER);
	textSize(30);
}

void DrawPlayer(int posX, int posY) {
	/*
	Draws the player "space ship" at the coordinates given by the 
	parameters. posX refers to the X coordinate of the center of the
	player, and posY refers to the Y coordinate of the top of the player.
	*/
	fill(#00FC00);

	rectMode(CENTER);
	rect(posX, posY + 20, 52, 16);
	rect(posX, posY + 10, 44, 04);
	rect(posX, posY + 06, 12, 8);
	rect(posX, posY + 00, 4, 4);
}

void CreatePlayer(int posX, int posY) {
	/*
	Compares the "posX" and "posY" parameters to various boundaries
	and draws the player depending on those conditionals.
	*/
	int leftBarrier = 30;
	int rightBarrier = width - 30;
	playerPosY = posY;

	if (posX > leftBarrier && posX < rightBarrier) {
		playerPosX = posX;

		DrawPlayer(posX, posY);
	}
	else if (posX < leftBarrier) {
		playerPosX = leftBarrier;

		DrawPlayer(leftBarrier, posY);
	}
	else if (posX > rightBarrier) {
		playerPosX = rightBarrier;

		DrawPlayer(rightBarrier, posY);
	}
}

void Shoot(int posX) {
	/*
	creates laser shot at the "posX" parameter
	*/
	fill(255);
	rect(posX, shotY, 5, 20);

}

void mousePressed() {
	/*
	If a laser shot doesn't exist, creates one
	*/
	if (!shotExists) {
		shotX = playerPosX;
		shotY = playerPosY - 10;
		shotExists = true;
	}
	
}

void ShotChecker() {
	/*
	Runs in background, controls various aspects of the laser shot.
	*/
	boolean collidesWithRoof1 = 45<shotX && shotX<145;
	boolean collidesWithRoof2 = 195<shotX && shotX<295;
	boolean collidesWithRoof3 = 345<shotX && shotX<445;
	boolean collidesWithRoof4 = 495<shotX && shotX<595;

	boolean collidesWithRoofs = collidesWithRoof1 || 
		collidesWithRoof2 || collidesWithRoof3 || collidesWithRoof4;


	if (shotExists) {
		Shoot(shotX);
		shotY -= shotSpeed;
	}
	if (shotY < 0 || (collidesWithRoofs) && shotY < 550) {
		shotExists = false;
	}
}

void RenderGUI() {
	/*
	Creates the SCORE in the top left of the screen (even though it
	can't be changed...)
	*/
	fill(255);
	textFont(pixelFont, 20);
	text("SCORE: " + score, 50, 20);
}

void RenderSI(int centerX, int centerY) {
	// this massive ClusterFuck of code creates one Space Invader.
	// I will not be making the other 5 types...
	rect(centerX, centerY + 5, 28, 8);
	rect(centerX, centerY, 12, 16);
	rect(centerX - 12, centerY + 10, 4, 4);
	rect(centerX + 12, centerY + 10, 4, 4);
	rect(centerX - 6, centerY + 14, 8, 4);
	rect(centerX + 6, centerY + 14, 8, 4);
	rect(centerX - 8, centerY - 10, 4, 4);
	rect(centerX + 8, centerY - 10, 4, 4);
	rect(centerX - 12, centerY - 14, 4, 4);
	rect(centerX + 12, centerY - 14, 4, 4);
	rect(centerX - 10, centerY - 6, 8, 4);
	rect(centerX + 10, centerY - 6, 8, 4);
	rect(centerX - 12, centerY - 1, 4, 6);
	rect(centerX + 12, centerY - 1, 4, 6);
	rect(centerX - 16, centerY - 0, 4, 8);
	rect(centerX + 16, centerY - 0, 4, 8);
	rect(centerX - 20, centerY + 6, 4, 12);
	rect(centerX + 20, centerY + 6, 4, 12);
}

void makeSIArray() {
	/*
	fills in the values of the x and y coordinates for all of the space
	invader sprites. This method is the main reason for the slowness
	at the beginning of this program's execution
	*/
	for (int i = 0; i<11; i++) {
		row1X[i] = sStartX + (i * 50);
		row2X[i] = sStartX + (i * 50);
		row3X[i] = sStartX + (i * 50);
		row4X[i] = sStartX + (i * 50);
		row5X[i] = sStartX + (i * 50);

		row1Y[i] = sStartY;
		row2Y[i] = sStartY + sDeltaY * 1;
		row3Y[i] = sStartY + sDeltaY * 2;
		row4Y[i] = sStartY + sDeltaY * 3;
		row5Y[i] = sStartY + sDeltaY * 4;
	}
}

void DrawSIArray() {
	/*
	Draws all of the Space Invaders based on the "row" arrays
	*/
	for (int i = 0; i<11; i++) {
		RenderSI(row1X[i], row1Y[i]);
		RenderSI(row2X[i], row2Y[i]);
		RenderSI(row3X[i], row3Y[i]);
		RenderSI(row4X[i], row4Y[i]);
		RenderSI(row5X[i], row5Y[i]);
	}
}

void DrawRoof(int posX, int posY) {
	/*
	Draws the "roofs" (not really sure what to call them) at the "posX"
	and "posY" coordinates
	*/
	image(roof, posX, posY, 88, 64);
}

void DrawRoofs() {
	/*
	Draws all 4 of the roofs
	*/
	DrawRoof(50, 525);
	DrawRoof(200, 525);
	DrawRoof(350, 525);
	DrawRoof(500, 525);
}

int FuckAll(int arg1, int arg2, int arg3, int arg4, boolean arg5) {
	/*
	Because I needed to fill this condition. I'm sure I'll use
	this for something. This function generates an int value that will
	be used as a psuedo-boolean value by incorporating it into an if 
	statement.
	*/
	if (arg5) {
		return ((arg1 + arg2)/arg3)- arg4;
	}
	else {
		return 4;
	}
}

boolean FuckAllBoolean(int arg1, int arg2, int arg3, int arg4, boolean arg5) {
	/*
	returns true
	*/
	int FuckAll = FuckAll(arg1, arg2, arg3, arg4, arg5);
	if (FuckAll < 685) {
		return true;
	}
	else {
		return !false;
	}
}

void FuckAllShow() {
	/*
	If that massive boolean above returns false (it won't) it shows the user
	a message that will never show up
	*/
	if (!FuckAllBoolean(1,5,77,mouseX,true)) {
		text("This will never show up.", 500, 500);
	}
}