#import bevy_pbr::mesh_view_bindings as view_bindings

@group(1) @binding(0) var<uniform> color: vec4<f32>;
@group(1) @binding(1) var texture: texture_2d<f32>;
@group(1) @binding(2) var samp: sampler;
@group(1) @binding(3) var<uniform> screen_size: vec2<f32>;

struct VertexInput {
  @location(0) position: vec3<f32>,
  @location(2) uv: vec2<f32>,
  @location(5) color: vec4<f32>,
  @builtin(vertex_index) vertex_index: u32,
}

struct VertexOutput {
  @builtin(position) clip_position: vec4<f32>,
}

@vertex
fn vertex(in: VertexInput) -> VertexOutput {
  var out: VertexOutput;
  out.clip_position = vec4(in.position * 2.0,1.0);
  return out;
}

struct FragmentInput {
  @builtin(position) frag_coord: vec4<f32>,
}

@fragment
fn fragment(in: FragmentInput) -> @location(0) vec4<f32> {  
  var i = in.frag_coord.x / (screen_size.x / 3.5) - 2.5;
  var j = in.frag_coord.y / (screen_size.y / 2.0) - 1.0;
  var zx = 0.0;
  var zy = 0.0;
  var iteration = 0;
  var max_iterations = 64;
  var xtemp: f32;
  while zx*zx + zy*zy < 4.0 && iteration < max_iterations {
    xtemp = (zx*zx) - (zy*zy) + i;
    zy = 2.0*zx*zy + j;
    zx = xtemp;
    iteration += 1;
  }
  var position = f32(iteration) / f32(max_iterations);
  return vec4(position, position, position, 1.0) * color;
}
