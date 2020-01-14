# 1/13/20
# Author: Will Solow

import os, sys
import pygame
from pygame.locals import *

def main(): 
	#checks if sound and font are imported
	if not pygame.font: 
		print("Warning, fonts disabled")
	if not pygame.mixer: 
		print("Warning, sound disabled")
	
	# initialize pygame library
	pygame.init()
	
	# load and set logo
	logo = pygame.image.load("resources/logo.png")
	pygame.display.set_icon(logo)
	# create and display screen
	screen = pygame.display.set_mode((1000, 500))
	# set caption of window
	pygame.display.set_caption("Single Dad Ninja")
	
	# define variable to keep window open
	gameState = True;
	
	# main game loop
	while gameState:
		#event handling, gets all events from queue
		for event in pygame.event.get():
			if event.type == pygame.QUIT:
				# change gameState to false and quit window
				gameState = False
			if event.type == pygame.KEYDOWN:
				# if q pressed, quit window
				if pygame.key.get_pressed()[K_q]:
					gameState = False

	
	
	# close pygame window and exit program
	pygame.display.quit()
	pygame.quit()
	sys.exit()
	
# run the main function only if this module is executed as the main script
if __name__ == "__main__":
	main();
