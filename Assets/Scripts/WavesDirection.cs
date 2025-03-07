﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteAlways]
public class WavesDirection : MonoBehaviour
{
    public Material oceanMaterial;
    
    public Transform dir1;
    public Transform dir2;
    public Transform dir3;
    public Transform dir4;

    private void Update()
    {
        oceanMaterial.SetVector("_Direction1", dir1.forward);
        oceanMaterial.SetVector("_Direction2", dir2.forward);
        oceanMaterial.SetVector("_Direction3", dir3.forward);
        oceanMaterial.SetVector("_Direction4", dir4.forward);
    }
}
