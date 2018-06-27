using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeshData : MonoBehaviour {

	public bool showLog = false;

	// Use this for initialization
	void Start () {
		LogVerticesVector3 ();
		
	}

	void LogVerticesVector3 ()
	{
		Mesh mesh = GetComponent<MeshFilter> ().mesh;
		Vector3[] vertices = mesh.vertices;
		foreach (Vector3 v in vertices) {
			Debug.Log (v);
		}
	}
	
	// Update is called once per frame
	void Update () {
		if (showLog) {
			showLog = false;
			LogVerticesVector3 ();
		}

	}
}
