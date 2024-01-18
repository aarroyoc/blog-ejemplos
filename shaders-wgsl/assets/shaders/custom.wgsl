#import bevy_pbr::mesh_view_bindings as view_bindings

@group(1) @binding(0) var<uniform> color: vec4<f32>;
@group(1) @binding(1) var texture: texture_2d<f32>;
@group(1) @binding(2) var samp: sampler;

struct VertexInput {
  @location(0) position: vec3<f32>,
  @location(2) uv: vec2<f32>,
  @location(5) color: vec4<f32>,
  @builtin(vertex_index) vertex_index: u32,
}

struct VertexOutput {
  @builtin(position) clip_position: vec4<f32>,
  @location(0) color: vec4<f32>,
  @location(1) uv: vec2<f32>,
}

@vertex
fn vertex(in: VertexInput) -> VertexOutput {
  var out: VertexOutput;
  out.clip_position = view_bindings::view.view_proj * vec4(in.position,1.0);
  out.uv = in.uv;
  out.color = in.color;
  return out;
}

struct FragmentInput {
  @builtin(position) frag_coord: vec4<f32>,
  @location(0) color: vec4<f32>,
  @location(1) uv: vec2<f32>,
}

@fragment
fn fragment(in: FragmentInput) -> @location(0) vec4<f32> {  
  return textureSample(texture, samp, in.uv) * in.color;
}
