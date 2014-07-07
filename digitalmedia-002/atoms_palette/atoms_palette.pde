Maxim maxim;
AudioPlayer player;

int window_size = 600;
int offset = 100;
int circle_size = window_size-offset;
int patter_circle_size = 50;

int[] red = {255, 0, 0};
int[] green = {0, 255, 0};
int[] blue = {0, 0,255};
int[] black = {0, 0, 0};

int[] red_circle_center = {int(circle_size/2+offset/2), int(0+offset/2)};
int[] green_circle_center = {int(sqrt(3)/2*circle_size/2+circle_size/2+offset/2), int(circle_size/4+circle_size/2+offset/2)};
int[] blue_circle_center = {int(circle_size/2-sqrt(3)/2*circle_size/2+offset/2), int(circle_size/4+circle_size/2+offset/2)};

void setup()
{
  size(window_size, window_size);
  maxim = new Maxim(this);
  background(40); // dark grey
  smooth();

  player = maxim.loadFile("ambient-loop.wav");
  player.setLooping(true);
  
}

void draw()
{
  player.play();
  draw_circle(circle_size/2+offset/2, circle_size/2+offset/2, circle_size, black, false);

  draw_circle(red_circle_center[0], red_circle_center[1], 40, red, true);
  draw_circle(green_circle_center[0], green_circle_center[1], 40, green, true);
  draw_circle(blue_circle_center[0], blue_circle_center[1], 40, blue, true);

  int mouse_dist_from_red_circle = dist_from_mouse(red_circle_center[0], red_circle_center[1]);
  int mouse_dist_from_green_circle = dist_from_mouse(green_circle_center[0], green_circle_center[1]);
  int mouse_dist_from_blue_circle = dist_from_mouse(blue_circle_center[0], blue_circle_center[1]);

  if (mouse_dist_from_red_circle <= circle_size-patter_circle_size && mouse_dist_from_green_circle <= circle_size-patter_circle_size && mouse_dist_from_blue_circle <= circle_size-patter_circle_size) {
    _stroke_color(red);
    line(mouseX, mouseY, red_circle_center[0], red_circle_center[1]);
 
    _stroke_color(green);
    line(mouseX, mouseY, green_circle_center[0], green_circle_center[1]);

    _stroke_color(blue);
    line(mouseX, mouseY, blue_circle_center[0], blue_circle_center[1]);

    int map_red = int(map(mouse_dist_from_red_circle, 0, circle_size, 255, 0));
    int map_green = int(map(mouse_dist_from_green_circle, 0, circle_size, 255, 0));
    int map_blue = int(map(mouse_dist_from_blue_circle, 0, circle_size, 255, 0));
    int[] cursor_color = {map_red, map_green, map_blue};

    draw_circle(mouseX, mouseY, patter_circle_size, cursor_color, true);

    int mouse_dict_from_center = int(dist(mouseX, mouseY, window_size/2, window_size/2));
    player.speed((float) 4*mouse_dict_from_center/window_size);
  }
}

void draw_circle(int x, int y, int circle_size, int[] col, boolean noStroke)
{
  _fill_color(col);
  if (noStroke == true) {
    noStroke();
  }
  ellipse(x, y, circle_size, circle_size);
}

void _fill_color(int[] col)
{
  fill(col[0], col[1], col[2]);
}

void _stroke_color(int[] col)
{
  stroke(col[0], col[1], col[2]);
}

int dist_from_mouse(int x, int y)
{
  return int(dist(mouseX, mouseY, x, y));
}
