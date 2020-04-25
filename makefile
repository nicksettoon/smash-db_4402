main.o: main.c
	gcc -c main.c

full:
	make
	./clock 20 pageref.txt 1 10 20

clean: 
	rm *.db

submit:
	make clean
	rm .*
	rm *.pdf
	rm *.code-workspace

git:
	make clean
	git add -A
	git commit -m $(msg)
	git push

