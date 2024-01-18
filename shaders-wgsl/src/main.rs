use bevy::prelude::*;
use bevy::render::mesh::Indices;
use bevy::render::render_resource::PrimitiveTopology;
use bevy::render::render_resource::ShaderRef;
use bevy::render::render_resource::AsBindGroup;

#[derive(AsBindGroup, Debug, Clone, Asset, TypePath)]
struct CustomMaterial {
    #[uniform(0)]
    color: Color,
    #[texture(1)]
    #[sampler(2)]
    image: Handle<Image>,
}

impl Material for CustomMaterial {
    fn vertex_shader() -> ShaderRef {
	"shaders/custom.wgsl".into()
    }
    fn fragment_shader() -> ShaderRef {
	"shaders/custom.wgsl".into()
    }

    fn alpha_mode(&self) -> AlphaMode {
	AlphaMode::Opaque
    }
}

fn setup_quad(mut commands: Commands, mut meshes: ResMut<Assets<Mesh>>, mut materials: ResMut<Assets<CustomMaterial>>, mut server: Res<AssetServer>) {
    let mesh = Mesh::new(PrimitiveTopology::TriangleList)
	.with_inserted_attribute(
	    Mesh::ATTRIBUTE_POSITION,
	    vec![
		[0.5, -0.5, 0.0],
		[-0.5, 0.5, 0.0],
		[-0.5, -0.5, 0.0],
		[0.5, 0.5, 0.0]
	    ])
	.with_inserted_attribute(
	    Mesh::ATTRIBUTE_UV_0,
	    vec![
		[1.0, 1.0],
		[0.0, 0.0],
		[0.0, 1.0],
		[1.0, 0.0],
	    ])
	.with_inserted_attribute(
	    Mesh::ATTRIBUTE_COLOR,
	    vec![
		[1.0, 0.0, 0.0, 1.0],
		[0.0, 1.0, 0.0, 1.0],
		[0.0, 0.0, 1.0, 1.0],
		[1.0, 1.0, 1.0, 1.0]
	    ])
	.with_indices(Some(Indices::U32(vec![
	    2,0,1,
	    0,3,1,
	])));

    let mesh_handle = meshes.add(mesh);
    let image_handle: Handle<Image> = server.load("tren.png");
    let material_handle = materials.add(CustomMaterial { color: Color::BLUE, image: image_handle});

    commands.spawn(MaterialMeshBundle {
	mesh: mesh_handle,
	material: material_handle,
	..default()
    });
}

fn setup_camera(mut commands: Commands) {
    commands.spawn(Camera3dBundle {
	transform: Transform::from_xyz(0.0, 0.0, 2.0).looking_at(Vec3::ZERO, Vec3::Y),
	..default()
    });
}

fn main() {
    App::new()
	.add_plugins((DefaultPlugins, MaterialPlugin::<CustomMaterial>::default()))
	.add_systems(Startup, (setup_camera, setup_quad))
	.run();
}
