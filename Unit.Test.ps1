BeforeAll { 
    function Get-Planet ([string]$Name = '*') {
        $planets = @(
            @{ Name = 'Mercury' }
            @{ Name = 'Venus'   }
            @{ Name = 'Earth'   }
            @{ Name = 'Mars'    }
            @{ Name = 'Jupiter' }
            @{ Name = 'Saturn'  }
            @{ Name = 'Uranus'  }
            @{ Name = 'Neptune' }
        ) | ForEach-Object { [PSCustomObject] $_ }

        $planets | Where-Object { $_.Name -like $Name }
    }
	
	function MakeHTTPCall {
		$Response = Invoke-WebRequest -URI https://www.bing.com/search?q=how+many+feet+in+a+mile
		$Response.InputFields | Where-Object {
			$_.name -like "* Value*"
		} | Select-Object Name, Value
	}
}
 
Describe 'Get-Planet' {
    It 'Given no parameters, it lists all 8 planets' {
        $allPlanets = Get-Planet
        $allPlanets.Count | Should -Be 8
    }
	
	It 'Make HTTP Call' {
		MakeHTTPCall
    }
}

