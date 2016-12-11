/* rlebel12 */

#include <stdio.h>
#include <math.h>
#include <stdlib.h>

struct cacheLine {
	int tag;
	int valid;
	struct cacheLine* next;
};

struct cacheSet {
	struct cacheLine* head;
	struct cacheLine* tail;
};

// Prints contents of cache 
void printCache(int s, int l, int k, struct cacheSet cache[], int n) {
	printf("Printing cache contents:\n");
	int TOTAL = 0;
	struct cacheLine* point;
	for (int i = 0; i < k; i++){
		int max = 0;
		if (n!=0) max = n;
		else max = s/l;
		for (int j = 0; j < max; j++){
			if (j == 0) point = cache[i].tail;
			else {
				point = point->next;
			}
			printf("%d:   SET: %d    LINE: %d    TAG: %d    VALID: %d\n", TOTAL, i, j, point->tag, point->valid);
			TOTAL++;
		}
	}	
	return;
}

void cacheSim(int s, int l, int k, int addresses[], int n, int size){
	// Create cache
	struct cacheSet cache[1000];
	for (int i = 0; i < k; i++){
		for (int j = 0; j < n; j++) {
			struct cacheLine* point;
			if (j == 0) {
				struct cacheLine* line = (struct cacheLine*)malloc(sizeof(struct cacheLine));
				line->tag = 0;
				line->valid = 0;
				line->next = 0;
				cache[i].head = line;
				point = line;
			}
			else {
				struct cacheLine* line = (struct cacheLine*)malloc(sizeof(struct cacheLine));
				line->tag = 0;
				line->valid = 0;
				line->next = point; // Clang-check throws warning, but 'point' will never be a null-pointer here
				point = line;	
			}
		if (n == 1) cache[i].tail = cache[i].head;
		else cache[i].tail = point;		
		} 
	}   	
	
	// Search for addresses
	for (int i = 0; i < size; i++){
		/* Uncomment next two lines to see cache contents before each search */
		//printf("\n");
		//printCache(s,l,k,cache,n);
		int search = addresses[i];
		int tag = (search/l)/k;
		int set = (search/l)-(tag*k);
		int offset = search%l;
		struct cacheLine* point;
		struct cacheLine* new_head = 0;
		int found = 0;
		if (n==1){
			if (cache[set].head->valid == 0){
				printf("%d: MISS  (Tag/Set#/Offset: %d/%d/%d)\n", search, tag, set, offset);
				cache[set].head->valid = 1;
			}
			else printf("%d: HIT   (Tag/Set#/Offset: %d/%d/%d)\n", search, tag, set, offset);
		}
		else {
			point = cache[set].tail;
			while (point!=0 && found == 0){
				if (point->valid == 1){
					if (point->tag == tag) {
						printf("%d: HIT   (Tag/Set#/Offset: %d/%d/%d)\n", search, tag, set, offset);
						found = 1;
					}
				}
				if (point->next == cache[set].head) {
					new_head = point;
				}
				point = point->next;
			}
			if (found == 0){
				printf("%d: MISS  (Tag/Set#/Offset: %d/%d/%d)\n", search, tag, set, offset);
				point = new_head;
				free(point->next);  // Without this line there could be an eventual significant memory leak with enough searches, but clang-check throws a warning with it
				point->next = 0;
				cache[set].head = point;
				struct cacheLine* line = (struct cacheLine*)malloc(sizeof(struct cacheLine));
				line->valid = 1;
				line->tag = tag;
				line->next = cache[set].tail;
				cache[set].tail = line;
			}
		}
}
	
	printCache(s,l,k,cache,n);	
	return;
}

int main(int argc, char *argv[]){
	int s, l, k;
	int n = 0;
	char c;
	
	// DEFINING ADDRESSES AND NUMBER OF ADDRESSES
	int addresses[] = {0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 0, 4, 8, 12, 16, 71, 3, 41, 81, 39, 38, 71, 15, 39, 11, 51, 57, 41}; 
	int size = 39; 

	printf("Enter the cache size (Bytes): ");
	scanf("%d", &s);
	printf("Enter the cache block (line) size (Bytes): ");
	scanf("%d", &l);
	printf("Direct Mapped?  Y/N: ");
	scanf(" %c", &c);
	if (c == 'y' || c == 'Y') {
		k = s/l;
		n = 1;
	}
	else {
		printf("Fully Associative?  Y/N: ");
		scanf(" %c", &c);
		if (c == 'y' || c == 'Y') {
			k = 1;
			n = s/l;
		}
		else {
			printf("Cache must be n-way set associative.  Enter n: ");
			scanf("%d", &n);
			k = (s/l)/n;
		}
	}
	cacheSim(s,l,k,addresses,n, size);
	return 0;
}
