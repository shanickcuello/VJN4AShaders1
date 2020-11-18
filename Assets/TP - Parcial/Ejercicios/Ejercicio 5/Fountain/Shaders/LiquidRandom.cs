using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class LiquidRandom : MonoBehaviour
{

    public float myNumber;
    public Material waterJet;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        myNumber = Random.Range(3, 10);
      //  waterJet.SetFloat("_RingWidth", myNumber);
    }
}
