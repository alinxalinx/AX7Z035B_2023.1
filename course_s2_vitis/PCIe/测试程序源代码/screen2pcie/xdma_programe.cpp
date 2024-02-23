#include "xdma_programe.h"

#define IMG_RAM_POS     (512*1024*1024)

xdma_programe::xdma_programe()
{
    dev_fd = INVALID_HANDLE_VALUE;
}

xdma_programe::~xdma_programe()
{
    if(dev_fd != INVALID_HANDLE_VALUE)
    {
        CloseHandle(dev_fd);
    }
}

int xdma_programe::write_pack(char *pData, int len)
{
    DWORD size;
    LARGE_INTEGER addr;

    memset(&addr, 0, sizeof(addr));
    addr.QuadPart = IMG_RAM_POS;

    if ((int)INVALID_SET_FILE_POINTER == SetFilePointerEx(dev_fd, addr, NULL, FILE_BEGIN))
    {
        return 0;
    }
    if (!WriteFile(dev_fd, pData, len, &size, NULL))
    {
        return 0;
    }
    return len;
}

bool xdma_programe::getDevice()
{
    bool b = false;
    HDEVINFO device_info;
    GUID guid = GUID_DEVINTERFACE_XDMA;
    SP_DEVICE_INTERFACE_DATA device_interface;
    DWORD index;
    int len;
    char *xdma_path;

    //获取设备路径
    if(dev_fd != INVALID_HANDLE_VALUE)
    {
        CloseHandle(dev_fd);
        dev_fd = INVALID_HANDLE_VALUE;
    }

    device_info = SetupDiGetClassDevs((LPGUID)&guid, NULL, NULL, DIGCF_PRESENT | DIGCF_DEVICEINTERFACE);
    if (device_info != INVALID_HANDLE_VALUE)
    {
        device_interface.cbSize = sizeof(SP_DEVICE_INTERFACE_DATA);
        for (index = 0; SetupDiEnumDeviceInterfaces(device_info, NULL, &guid, index, &device_interface); ++index)
        {
            // get required buffer size
            ULONG detailLength = 0;
            if (!SetupDiGetDeviceInterfaceDetail(device_info, &device_interface, NULL, 0, &detailLength, NULL) && GetLastError() != ERROR_INSUFFICIENT_BUFFER)
            {
                break;
            }

            // allocate space for device interface detail
            PSP_DEVICE_INTERFACE_DETAIL_DATA dev_detail = (PSP_DEVICE_INTERFACE_DETAIL_DATA)HeapAlloc(GetProcessHeap(), HEAP_ZERO_MEMORY, detailLength);
            if (!dev_detail)
            {
                break;
            }
            dev_detail->cbSize = sizeof(SP_DEVICE_INTERFACE_DETAIL_DATA);

            // get device interface detail
            if (!SetupDiGetDeviceInterfaceDetail(device_info, &device_interface, dev_detail, detailLength, NULL, NULL))
            {
                HeapFree(GetProcessHeap(), 0, dev_detail);
                break;
            }

            len = wcslen( dev_detail->DevicePath);
            xdma_path = (char *)malloc((len+40)*2);
            if(xdma_path)
            {
                memcpy(xdma_path, dev_detail->DevicePath, len*2);
                memcpy(xdma_path+len*2, XDMA_FILE_H2C_0, sizeof(L"\\c2h_0"));
                dev_fd = CreateFile((LPCWSTR)xdma_path, GENERIC_WRITE, 0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
                free(xdma_path);
                b = true;

                COMMTIMEOUTS CommTimeouts;
                if(dev_fd != INVALID_HANDLE_VALUE)
                {
                    CommTimeouts.ReadIntervalTimeout = 1000;
                    CommTimeouts.ReadTotalTimeoutMultiplier = 1000;
                    CommTimeouts.ReadTotalTimeoutConstant = 1000;
                    CommTimeouts.WriteTotalTimeoutMultiplier = 1000;
                    CommTimeouts.WriteTotalTimeoutConstant = 1000;
                    SetCommTimeouts(dev_fd, &CommTimeouts);
                }
            }
            HeapFree(GetProcessHeap(), 0, dev_detail);
            break;
        }
        SetupDiDestroyDeviceInfoList(device_info);
    }
    return b;
}


