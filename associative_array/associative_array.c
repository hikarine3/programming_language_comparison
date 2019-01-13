#include <stdio.h>
#include <stdlib.h>
 
typedef struct {
    int size;
    void **keys;
    void **values;
} hash_t;
 
hash_t *hash_new (int size) {
    hash_t *h = calloc(1, sizeof (hash_t));
    h->keys = calloc(size, sizeof (void *));
    h->values = calloc(size, sizeof (void *));
    h->size = size;
    return h;
}
 
int hash_index (hash_t *h, void *key) {
    int i = (int) key % h->size;
    while (h->keys[i] && h->keys[i] != key)
        i = (i + 1) % h->size;
    return i;
}
 
void hash_insert (hash_t *h, void *key, void *value) {
    int i = hash_index(h, key);
    h->keys[i] = key;
    h->values[i] = value;
}
 
void *hash_lookup (hash_t *h, void *key) {
    int i = hash_index(h, key);
    return h->values[i];
}
 
int main () {
    hash_t *h = hash_new(15);
    hash_insert(h, "1", "January");
    hash_insert(h, "2", "February");
    hash_insert(h, "3", "March");
    printf("%s\n", hash_lookup(h, "1"));
    printf("%s\n", hash_lookup(h, "2"));
    printf("%s\n", hash_lookup(h, "3"));
    return 0;
}