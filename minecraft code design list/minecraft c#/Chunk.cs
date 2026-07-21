using Godot;
using System;
using System.Runtime.InteropServices;
//[Tool]
public partial class Chunk : StaticBody3D
{
	public CollisionShape3D collisionShape3D;
	public MeshInstance3D meshInstance3D;

	public static Vector3I dimensions = new Vector3I(8,16,8);

	public static readonly Vector3I[] _vertices =
    [
        new Vector3I(0,0,0),
		new Vector3I(1,0,0),
		new Vector3I(0,1,0),
		new Vector3I(1,1,0),
		new Vector3I(0,0,1),
		new Vector3I(1,0,1),
		new Vector3I(0,1,1),
		new Vector3I(1,1,1)
		
	];

	private static readonly int[] _top = [2,3,7,6];
	private static readonly int[] _bottom = [0,4,5,1];
	private static readonly int[] _left = [6,4,0,2];
	private static readonly int[] _right = [3,1,5,7];
	private static readonly int[] _back = [7,5,4,6];
	private static readonly int[] _front = [2,0,1,3];

	private SurfaceTool _surfaceTool= new();
	
	private Block[,,] _blocks = new Block[dimensions.X,dimensions.Y,dimensions.Z]; // dunno what this do , know this purpose 
	public override void _Ready()
	{
		collisionShape3D = GetNode<CollisionShape3D>("CollisionShape3D");
		meshInstance3D = GetNode<MeshInstance3D>("MeshInstance3D");

		GD.Print("ready worked");

		//Generate();
		/*
		var time = Time.get_datetime_dict_from_system()
		var current = time.second
		print("current : ", current)
		print(time)
		update()
		time = Time.get_datetime_dict_from_system()
		print("time : ",time.second-current)
		print(time)
		*/
		var time = Time.GetDatetimeDictFromSystem();
		GD.Print(time);
		int current = (int)time["second"];
		GD.Print("current : "+ current);
		GD.Print(time);
		Update();
		time = Time.GetDatetimeDictFromSystem();
		int x = (int)time["second"]-current;
        GD.Print("current past : "+current+"  current now : "+(int)time["second"]+" time : " + x);
		GD.Print(time);

	}


	public void Generate()
	{
						//populate the chunk by objects of block
		Block block= new Block();

		for (int x = 0; x<dimensions.X ; x++)
		{
			for (int y = 0; y<dimensions.Y ; y++)
			{
				for (int z=0; z < dimensions.Z; z++)
				{
					_blocks[x,y,z] = block;
					GD.Print("another block spawn");
				}
			}
		}
	}
	public void Update()
	{
		_surfaceTool.Begin(Mesh.PrimitiveType.Triangles);

		for (int x = 0; x<dimensions.X ; x++)
		{
			for (int y = 0; y<dimensions.Y ; y++)
			{
				for (int z=0; z < dimensions.Z; z++)
				{
					CreateBlockMesh(new Vector3I(x,y,z));
					GD.Print("another mesh created : x : "+x+" y : "+y+" z : "+z);
				}
			}
		}
	}

	private void CreateBlockMesh(Vector3I blockPosition)
	{
		if(CheckTransparent(blockPosition + Vector3I.Up))
		{
			CreateFaceMesh(_top, blockPosition);
		}
		if(CheckTransparent(blockPosition + Vector3I.Down))
		{
			CreateFaceMesh(_bottom, blockPosition);
		}
		if(CheckTransparent(blockPosition + Vector3I.Left))
		{
			CreateFaceMesh(_left, blockPosition);
		}
		if(CheckTransparent(blockPosition + Vector3I.Right))
		{
			CreateFaceMesh(_right, blockPosition);
		}
		if(CheckTransparent(blockPosition + Vector3I.Forward))
		{
			CreateFaceMesh(_front, blockPosition);
		}
		if(CheckTransparent(blockPosition + Vector3I.Back))
		{
			CreateFaceMesh(_back, blockPosition);
		}
	}
	
	private void CreateFaceMesh(int[] face, Vector3I blockPosition)
	{

		//
		var a = _vertices[face[0]] + blockPosition;
		var b = _vertices[face[1]] + blockPosition;
		var c = _vertices[face[2]] + blockPosition;
		var d = _vertices[face[3]] + blockPosition;

		var triangle1 = new Vector3[]{a,b,c}; //triagle na isa ,
		var triangle2 = new Vector3[]{a,c,d}; // pangalawang triagle so naka buo na ng square 

		_surfaceTool.AddTriangleFan(triangle1); // draw triagle 
		_surfaceTool.AddTriangleFan(triangle2);

		var mesh = _surfaceTool.Commit();

		meshInstance3D.Mesh = mesh;
		collisionShape3D.Shape = mesh.CreateConvexShape();


	}
	private bool CheckTransparent(Vector3I blockPosition)
	{
		return true;
	}
}
