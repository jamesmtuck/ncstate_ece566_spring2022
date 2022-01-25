%.ll:%.c
	clang-13 -emit-llvm -S -o $@ $<

%.ll:%.bc
	llvm-dis-13 $<

%:%.ll
	clang-13 -o $@ $<


TESTS = test

clean:
	rm -f *.ll *.bc $(TESTS)
