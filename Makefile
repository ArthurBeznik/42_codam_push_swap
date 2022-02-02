# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Makefile                                           :+:    :+:             #
#                                                      +:+                     #
#    By: abeznik <abeznik@student.codam.nl>           +#+                      #
#                                                    +#+                       #
#    Created: 2022/02/01 13:52:46 by abeznik       #+#    #+#                  #
#    Updated: 2022/02/02 16:43:19 by abeznik       ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

NAME		:=	push_swap

# Directories
INCL_DIR	:=	includes
SRCS_DIR	:=	srcs
OBJ_DIR		:=	objs
VPATH 		:=	$(subst $(space),:,$(shell find srcs -type d))

# Srcs
SRCS		=	main.c \
				radix_sort.c \
				pancake.c \
				exit_message.c \
				ft_split.c \
				ft_strlen.c \
				ft_substr.c \

OBJS		=	$(addprefix $(OBJ_DIR)/, $(SRCS:.c=.o))

# Config
CC			:=	gcc
FLAGS		:=	-Wall -Wextra -g #-Werror || annoying during development

all:		$(NAME)

$(NAME):	$(OBJS)
	@$(CC) $(OBJS) $(FLAGS) -o $(NAME)
	@echo success!

$(OBJ_DIR)/%.o: $(notdir %.c)
	@mkdir -p $(OBJ_DIR)
	@echo "compiling $(notdir $(basename $@))"
	@$(CC) $(FLAGS) -c $< -I$(INCL_DIR) -o $@

run: all
	./$(NAME)

drun: all
	lldb $(NAME)

test:
	@$(MAKE) -C unit-tests

local:
	TEST=1
	@echo $(SRCS)

echo:
	@$(MAKE) -C unit-tests echo

clean:
	@rm -rf $(OBJ_DIR)
	@rm -rf $(NAME)

fclean:	clean
	@rm -f $(NAME)

re:	fclean all

.PHONY:	all clean fclean re