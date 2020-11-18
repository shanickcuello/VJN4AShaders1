using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Experimental.PlayerLoop;

public class Switcher : MonoBehaviour
{
    [SerializeField]
    private GameObject[] objectsToActivate;

    public Camera mainCamera;
    public Camera orthographic;
    
    private void Update()
    {
        if (gameObject.activeSelf)
        {
            mainCamera.gameObject.SetActive(true);
            orthographic.gameObject.SetActive(false);
            
            for (int i = 0; i < objectsToActivate.Length; i++)
            {
                objectsToActivate[i].SetActive(true);
            }
        }

        if (!gameObject.activeSelf)
        {
            for (int i = 0; i < objectsToActivate.Length; i++)
            {
                objectsToActivate[i].SetActive(false);
            }
        }
    }
}
