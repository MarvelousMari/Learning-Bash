#!/bin/bash

# This script displays various information to the screen.

# Display 'Hello'
echo 'Hello'
# Assig a value to a variable
WORD='script'


# Display value using the variable.
echo "$WORD"

# Demonstrate that single quotes cause variable to NOT get expanded.
echo '$WORD'

# combine the variable with hard-coded text.
echo "This is a shell $WORD"

#Display contents of variable using an alternative syntax.
echo "this is a shell ${WORD}"

# Append text to the variable
echo "${WORD}ing is fun!"


# Create a new variable
ENDING='ed'


# Combine variables
echo "This is ${WORD}${ENDING}."

# Cha ge the value stored in ENDING variable. (REassignment.)
ENDING='ing'
echo "${WORD}${ENDING} is fun"

# REassign calue to ENDING.
ENDING='s'
echo "You are going to write many ${WORD}${ENDING} in this class"
