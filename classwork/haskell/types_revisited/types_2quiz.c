typedef enum {
  EGG,
  LARVA,
  PUPA,
  ADULT
} stage_t;

stage_t next(stage_t stage) {
  return stage + 1;
}